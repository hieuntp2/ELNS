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
    public class HomeController : Controller
    {
       // FitNotificationDBEntities db = new FitNotificationDBEntities();

        public ActionResult Index()
        { 
            HtmlDocument doc = LoginandParseHTML("http://elearning.eduapps.edu.vn/uel/course/view.php?id=65");
            ParshData(doc);

            return View();
        }

        private void ParshData(HtmlDocument doc)
        {
            HtmlNodeCollection nodelist = doc.DocumentNode.SelectNodes("//*[@id='region-main']/div/div/div/ul/li[@class='activity resource modtype_resource'");

             foreach (HtmlNode node in nodelist)
            {
                NewPost item = new NewPost();                
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
         

        //public ActionResult Baiviet()
        //{

        //    List<Post> posts = db.Posts.OrderByDescending(t => t.NgayTao).ToList();
        //    return View(posts);
        //}

        //public ActionResult DaDangNhap()
        //{
        //    return View();
        //}

        //public ActionResult ChinhSachBaoMat()
        //{
        //    return View();
        //}

        //public ActionResult DieuKhoan()
        //{
        //    return View();
        //}

        //public ActionResult GioiThieu()
        //{
        //    return View();            
        //}
    }

}