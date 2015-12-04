﻿using FootballData.Controllers;
using HtmlAgilityPack;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace FootballData
{
    public partial class Team : System.Web.UI.Page
    {

        public TeamClass team;
        public PlayersList players_list;
        public String players_list_html;
        public String fixturesTable_html;
        protected String news_html;
        protected int paginationNews;

        private SqlConnection con;

        protected int db_news = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            con = ConnectionDB.getConnection();

            var feed_language = "en";

            int id = 1;
            try
            {
                id = int.Parse(Request["ID"]);
            }
            catch (Exception) { }

            // get team data

            var url = "http://api.football-data.org/v1/teams/" + id + "/";
            var syncClient = new WebClient();
            syncClient.Headers.Add("X-Auth-Token", "9cf843e4d69b4817ba99eba1ea051c10");
            syncClient.Headers.Add(HttpRequestHeader.ContentType, "application/json; charset=utf-8");

            var content = syncClient.DownloadString(url);
            team = JsonConvert.DeserializeObject<TeamClass>(content);

            url = team._links.players.href;
            syncClient = new WebClient();
            syncClient.Headers.Add("X-Auth-Token", "9cf843e4d69b4817ba99eba1ea051c10");
            syncClient.Headers.Add(HttpRequestHeader.ContentType, "application/json; charset=utf-8");

            content = syncClient.DownloadString(url);
            players_list = JsonConvert.DeserializeObject<PlayersList>(content, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore });

            players_list_html += "";

            foreach (Player p in players_list.players)
            {
                players_list_html += "<tr><td>" + p.name + "</td><td>" + p.jerseyNumber + "</td><td>" + p.position + "</td><td>" + p.nationality + "</td><td>" + p.dateOfBirth + "</td><td>" + p.marketValue + "</td><td>" + p.contractUntil + "</td></tr>";
            }
            
            url = team._links.fixtures.href;
            syncClient = new WebClient();
            syncClient.Headers.Add("X-Auth-Token", "9cf843e4d69b4817ba99eba1ea051c10");
            syncClient.Headers.Add(HttpRequestHeader.ContentType, "application/json; charset=utf-8");

            content = syncClient.DownloadString(url);
            var team_fixtures_list = JsonConvert.DeserializeObject<FixtureTeam>(content);

            foreach (FixtureGame fix in team_fixtures_list.fixtures)
            {
                fixturesTable_html += "<tr><td>" + fix.date.ToString().Replace("Z", " ").Replace("T", " ") + "</td><td><a href=\"Team.aspx?ID=" + fix._links.homeTeam.href.ToString().Replace("http://api.football-data.org/v1/teams/", "") + "\">" + fix.homeTeamName + "</a></td><td><a href=\"Team.aspx?ID=" + fix._links.awayTeam.href.ToString().Replace("http://api.football-data.org/v1/teams/", "") + "\">" + fix.awayTeamName + "</a></td>";
                if (fix.status == "FINISHED")
                {
                    fixturesTable_html += "<td>" + fix.result.goalsHomeTeam + "-" + fix.result.goalsAwayTeam + "</td>";
                }
                else
                {
                    fixturesTable_html += "<td>--</td>";
                }
                fixturesTable_html += "</tr>";
            }

            // NEWWWWS
            // see if team has news stored or not
            string CmdString = "SELECT football.udf_team_has_news(@team_id)";
            SqlCommand cmd = new SqlCommand(CmdString, con);
            cmd.Parameters.AddWithValue("@team_id", Convert.ToInt32(id));
            cmd.CommandType = CommandType.Text;
            
            try
            {
                con.Open();
                db_news = (int)cmd.ExecuteScalar();
                con.Close();
            }
            catch (Exception exc)
            {
                con.Close();
            }

            if (db_news == 0)
            {
                // google find
                Hashtable domains = new Hashtable();
                domains.Add("en", "co.uk");
                domains.Add("pt", "pt");
                domains.Add("de", "de");

                url = "https://news.google."+ domains[feed_language] + "/news/feeds?pz=1&cf=all&q=" + Server.UrlEncode(team.name) + "&output=rss";

                XmlReader reader = XmlReader.Create(url);
                XmlDocument doc = new XmlDocument();
                doc.Load(reader);
                reader.Close();

                XmlDataSourceGoogle_feed.Data = doc.OuterXml;
                XmlDataSourceGoogle_feed.DataBind();
                XmlDataSourceGoogle_feed.XPath = "/rss/channel";

                XmlDocument xdoc = XmlDataSourceGoogle_feed.GetXmlDocument();
                XmlElement root = xdoc.DocumentElement;
                XmlNodeList nodes_items = root.SelectNodes("/rss/channel/item");

                news_html = "";

                int id_int = 0;

                foreach (XmlNode node in nodes_items)
                {
                    id_int++;

                    String node_html = "<div id=\"new_id_" + id_int + "\"";
                    node_html += "class=\"col-xs-12 col-md-6 col-lg-6\"><div class=\"well\"> <div class=\"media\"> <div class=\"media-body\"> <h4 class=\"media-heading\"><a target=\"_blank\" href=\"" + node.Attributes[2].Value + "\">" + node.Attributes[0].Value + "</a></h4> <p>" + Regex.Replace(Regex.Replace(node.Attributes[1].Value, @"<b><font.*>.*<\/font><\/b><\/font><br>", " "), @"</font><br><font.*><a.*|<b><font.*>.*<\/font><\/b><\/font><br>|<br><font.*>.*</font></a>|​|<nobr>.*<\/nobr>|<.*?>", "") + "</p><span class=\"text-center\"><small><i class=\"fa fa-calendar - check - o\"></i> " + node.Attributes[5].Value + "</small></span></div></div></div>";

                    HtmlDocument doc_html = new HtmlDocument();
                    doc_html.LoadHtml(node.Attributes[1].Value);

                    var html_a = doc_html.DocumentNode.SelectNodes("//a").ToList();

                    if (html_a.ToArray().Length > 3)
                    {
                        node_html += "<div class=\"btn-group dropup pull-right\" style=\"margin-top: -20px;\"><button type=\"button\" class=\"btn btn-default btn-xs\" disabled=\"disabled\">Related news</button><button type=\"button\" class=\"btn btn-default dropdown-toggle btn-xs\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><span class=\"caret\"></span><span class=\"sr-only\">Toggle Dropdown</span></button><ul class=\"dropdown-menu\">";

                        for (var i = 2; i < html_a.ToArray().Length - 1; i++)
                        {
                            node_html += "<li><a target=\"_blank\" href=\"" + html_a[i].Attributes[0].Value + "\">" + html_a[i].InnerText + "</a></li>";
                        }

                        node_html += "<!-- Dropdown menu links --></ul></div>";
                    }

                    news_html += (node_html + "</div>");
                }

                paginationNews = id_int;
            }
            else
            {
                String CmdString1 = "SELECT * FROM football.udf_get_team_news(@team_id, @language)";
                SqlCommand cmd1 = new SqlCommand(CmdString1, con);
                cmd1.Parameters.AddWithValue("@team_id", Convert.ToInt32(id));
                cmd1.Parameters.AddWithValue("@language", feed_language);
                SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
                DataTable dt1 = new DataTable("teams");
                sda1.Fill(dt1);

                int id_int = 0;
                news_html = "";
                
                foreach (DataRow teamNew in dt1.Rows)
                {
                    id_int++;

                    var news_id = (int)teamNew.ItemArray[0];
                    var news_title = (string)teamNew.ItemArray[1];
                    var news_link = (string)teamNew.ItemArray[2];
                    var news_description = (string)teamNew[3];
                    var news_date = (DateTime)teamNew[4];

                    var node_html = (string)"<div id=\"new_id_" + id_int + "\"";
                    node_html += "class=\"col-xs-12 col-md-6 col-lg-6\"><div class=\"well\"> <div class=\"media\"> <div class=\"media-body\"> <h4 class=\"media-heading\"><a target=\"_blank\" href=\"" + news_link + "\">" + news_title + "</a></h4> <p>" + news_description + "</p><span class=\"text-center\"><small><i class=\"fa fa-calendar - check - o\"></i> " + news_date.ToString() + "</small></span></div></div></div>";

                    // related news
                    String CmdString2 = "SELECT * FROM football.udf_get_team_news_related(@related_id)";
                    SqlCommand cmd2 = new SqlCommand(CmdString2, con);
                    cmd2.Parameters.AddWithValue("@related_id", Convert.ToInt32(news_id));
                    SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
                    DataTable dt2 = new DataTable("relatedNews");
                    sda2.Fill(dt2);

                    if (dt2.Rows.Count != 0)
                    {
                        node_html += "<div class=\"btn-group dropup pull-right\" style=\"margin-top: -20px;\"><button type=\"button\" class=\"btn btn-default btn-xs\" disabled=\"disabled\">Related news</button><button type=\"button\" class=\"btn btn-default dropdown-toggle btn-xs\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><span class=\"caret\"></span><span class=\"sr-only\">Toggle Dropdown</span></button><ul class=\"dropdown-menu\">";

                        foreach (DataRow teamRelatedNews in dt2.Rows)
                        {
                            var related_id = (int)teamRelatedNews.ItemArray[0];
                            var title = (string)teamRelatedNews.ItemArray[1];
                            var link = (string)teamRelatedNews.ItemArray[2];

                            node_html += "<li><a target=\"_blank\" href=\"" + link + "\">" + title + "</a></li>";
                        }

                        node_html += "<!-- Dropdown menu links --></ul></div>";
                    }
                    
                    news_html += (node_html + "</div>");
                }
                
                paginationNews = id_int;
            }
            
            Page.DataBind();
        }
    }
}