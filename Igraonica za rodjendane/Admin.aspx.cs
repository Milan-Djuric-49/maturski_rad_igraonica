using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace Igraonica_za_rodjendane
{
    public partial class Admin : System.Web.UI.Page
    {
        string datum;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Korisnik.user_uloga != 1)
                {
                    Response.Redirect("Login.aspx");
                }


                Label1.Text = Korisnik.user_ime + " " + Korisnik.user_prezime;

                Rezervacije_Populate();

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedIndex < 0 || GridView1.SelectedIndex < 0 || GridView1.Rows.Count <= GridView1.SelectedIndex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Izaberite rezervaciju i animatora')", true);
            }
            else
            {
                int red = int.Parse(GridView1.SelectedRow.RowIndex.ToString());
                string id = GridView1.Rows[red].Cells[1].Text;
                string igraonica_id = GridView1.Rows[red].Cells[4].Text;
                datum = (DateTime.Parse(GridView1.Rows[red].Cells[6].Text)).ToString("yyyy-MM-dd");
                string animator_id = DropDownList1.SelectedValue;

                SqlConnection veza = Konekcija.Connect();
                string naredba = "EXEC Odobri_Rezervacija " + id + ", " + animator_id;
                SqlCommand komanda = new SqlCommand(naredba, veza);

                veza.Open();
                komanda.ExecuteNonQuery();

                naredba = "DELETE FROM Rezervacija WHERE odobrena = 0 AND datum = '" + datum + "'" + " AND igraonica_id = " + igraonica_id;
                komanda = new SqlCommand(naredba, veza);
                komanda.ExecuteNonQuery();
                veza.Close();

                Rezervacije_Populate();
            }
        }

        private void Rezervacije_Populate()
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Rezervacija.id, korisnik_id, Korisnik.ime + ' ' + Korisnik.prezime AS naziv, igraonica_id, Igraonica.adresa AS adresa, datum FROM Rezervacija JOIN Korisnik ON korisnik_id = Korisnik.id JOIN Igraonica ON igraonica_id = Igraonica.id WHERE odobrena = 0", Konekcija.Connect());
            DataTable tabela = new DataTable();
            adapter.Fill(tabela);
            GridView1.DataSource = tabela;
            GridView1.DataBind();
        }

        private void Animator_Populate()
        {
            SqlConnection veza = Konekcija.Connect();
            int dan = (int) (DateTime.ParseExact(datum, "yyyy-MM-dd", null).DayOfWeek);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT Animator.id, ime + ' ' + prezime as naziv FROM Animator JOIN AnimatorRadniDan ON animator_id = Animator.id WHERE dan = " + dan, veza);
            DataTable dt_animator = new DataTable();
            adapter.Fill(dt_animator);
            DropDownList1.DataSource = dt_animator;
            DropDownList1.DataValueField = "id";
            DropDownList1.DataTextField = "naziv";
            DropDownList1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int red = int.Parse(GridView1.SelectedRow.RowIndex.ToString());
            datum = (DateTime.Parse(GridView1.Rows[red].Cells[6].Text)).ToString("yyyy-MM-dd");
            Animator_Populate();
        }
    }
}