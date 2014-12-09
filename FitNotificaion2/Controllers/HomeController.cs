using ELearning_Notification_Service.Class;
using Facebook;
using FitNotificaion2.Models;
using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FitNotificaion2.Controllers
{
    [RequireHttps]
    public class HomeController : Controller
    {
        ELearningNotificationServiceEntities db = new ELearningNotificationServiceEntities();

        private List<NewPost> listnewpost = new List<NewPost>();
        public ActionResult Index()
        { 
            //string href = "http://elearning.eduapps.edu.vn/uel/course/view.php?id=65";
            //HtmlDocument doc = LoginandParseHTML(href);
            //ParshDataHtml(doc, href);

            //EndTask();

            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Account");
            }
            else
            {
                return View();
            }
        }

        private void ParshDataHtml(HtmlDocument doc, string href)
        {
            HtmlNodeCollection nodelist = doc.DocumentNode.SelectNodes("//*[contains(@id,'module')]");

             foreach (HtmlNode node in nodelist)
            {
                NewPost item = new NewPost();
                item.id = node.Attributes["id"].Value;

                // XPATH: "/div/div/a/span" Lay ten cua node
                HtmlNode namenode = node.ChildNodes[0].ChildNodes[0].ChildNodes[0].ChildNodes[1];
                item.TieuDe = namenode.InnerText;
                item.NgayPost = DateTime.Now;
                item.href = href;

                CheckNewPost(item);
            }
        }

        private void CheckNewPost(NewPost post)
        {
            Post item = db.Posts.SingleOrDefault(t => t.IDPost == post.id);

            if (item == null)
            {
                post.isNewPost = true;
                listnewpost.Add(post);

                item = new Post();
                item.Title = post.TieuDe;
                item.IDPost = post.id;
                item.HrefTrack = post.href;               

                addPostToDatabase(item);
            }
            else
            {
                post.isNewPost = false;
            }
        }

        private void addPostToDatabase(Post post)
        {
            try
            {
                db.Posts.Add(post);
                db.SaveChanges();
            }
            catch(Exception e)
            {
                Unities.WriteLog("LOI khi ghi Post: " + post.IDPost + ": " + post.Title + ". " + e.ToString());
            }
        }

        private HtmlDocument LoginandParseHTML(string href)
        {
            BrowserSession b = new BrowserSession();
            b.Get("http://elearning.eduapps.edu.vn/uel/login/index.php");
            b.FormElements["username"] = "ngant";   
            b.FormElements["password"] = "0984567581";
            b.Post("http://elearning.eduapps.edu.vn/uel/login/index.php");

            string view = b.Get(href);

            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(view);

            return doc;
        }
         
        private void EndTask()
        {
            listnewpost.Clear();
        }

        public ActionResult Baiviet()
        {

            List<Post> posts = db.Posts.OrderByDescending(t => t.DateCreate).ToList();
            return View(posts);
        }

        public ActionResult DaDangNhap()
        {
            return View();
        }

        public ActionResult ChinhSachBaoMat()
        {
            return View();
        }

        public ActionResult DieuKhoan()
        {
            return View();
        }

        public ActionResult GioiThieu()
        {
            return View();
        }
    }

}