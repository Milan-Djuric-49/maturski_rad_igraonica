using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Igraonica_za_rodjendane
{
    public partial class Korisnik1 : System.Web.UI.Page
    {
        public DataTable dt_rezervacije = new DataTable();
        public string igraonica = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Korisnik.user_uloga != 0)
                {
                    Response.Redirect("Login.aspx");
                }

                Label1.Text = Korisnik.user_ime + " " + Korisnik.user_prezime;
                IgraonicaPopulate();
                Calendar1.Enabled = false;
            }
        }

        private void IgraonicaPopulate()
        {
            SqlConnection veza = Konekcija.Connect();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Igraonica", veza);
            DataTable dt_igraonice = new DataTable();
            adapter.Fill(dt_igraonice);
            DropDownList1.DataSource = dt_igraonice;
            DropDownList1.DataValueField = "id";
            DropDownList1.DataTextField = "adresa";
            DropDownList1.DataBind();
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            SqlConnection veza = Konekcija.Connect();
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Rezervacija WHERE igraonica_id = " + igraonica + " AND odobrena = 1", veza);
            dt_rezervacije = new DataTable();
            adapter.Fill(dt_rezervacije);
            for (int i = 0; i < dt_rezervacije.Rows.Count; i++)
            {
                string ds = dt_rezervacije.Rows[i]["datum"].ToString();
                DateTime datum = DateTime.Parse(ds);
                if (e.Day.Date == datum)
                {
                    e.Day.IsSelectable = false;
                    e.Cell.BackColor = System.Drawing.Color.Red;
                }
            }
            if (e.Day.IsOtherMonth)
            {
                e.Day.IsSelectable = false;
                //e.Cell.BackColor = System.Drawing.Color.Black;
            }
            if (e.Day.Date <= DateTime.Now)
            {
                e.Cell.BackColor = System.Drawing.Color.Gray;
                e.Day.IsSelectable = false;
            }

            if (IsPostBack && Calendar1.Enabled == true)
            {
                igraonica = DropDownList1.SelectedValue;
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Calendar1.Visible = false;
            Calendar1.Visible = true;
            Calendar1.Enabled = true;

            igraonica = DropDownList1.SelectedValue;
            Podaci.igraonica = igraonica;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Calendar1.SelectedDate == null || Calendar1.SelectedDate == Convert.ToDateTime("01/01/0001"))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Izaberite datum')", true);
            }
            else
            {
                SqlConnection veza = Konekcija.Connect();
                StringBuilder naredba = new StringBuilder("EXEC Dodaj_Rezervacija " + Korisnik.user_id + ", " + Podaci.igraonica + ", 1, " + "'" + Calendar1.SelectedDate.ToString("yyyy-MM-dd") + "'" + ", 0");
                SqlCommand komanda = new SqlCommand(naredba.ToString(), veza);
                //Label1.Text = naredba.ToString();
                try
                {
                    veza.Open();
                    komanda.ExecuteNonQuery();
                    veza.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Uspesno ste poslali zahtev za rezervaciju')", true);
                }
                catch (Exception greska)
                {
                    Console.WriteLine(greska.Message);
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            igraonica = "0";
            Calendar1.Enabled = false;
            Calendar1.SelectedDate = Convert.ToDateTime("01/01/0001");
        }
    }
}