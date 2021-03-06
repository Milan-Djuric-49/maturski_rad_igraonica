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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text == "" || TextBox2.Text == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Unesite sve podatke')", true);
            }
            else
            {

                try
                {
                    SqlConnection veza = Konekcija.Connect();
                    SqlCommand komanda = new SqlCommand("SELECT * FROM Korisnik where email =@username", veza);
                    komanda.Parameters.AddWithValue("@username", TextBox1.Text);
                    SqlDataAdapter adapter = new SqlDataAdapter(komanda);
                    DataTable tabela = new DataTable();
                    adapter.Fill(tabela);
                    int brojac = tabela.Rows.Count;
                    if (brojac == 1)
                    {
                        if (string.Compare(tabela.Rows[0]["password"].ToString(), TextBox2.Text) == 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Uspesna prijava')", true);
                            Korisnik.user_ime = tabela.Rows[0]["ime"].ToString();
                            Korisnik.user_prezime = tabela.Rows[0]["prezime"].ToString();
                            Korisnik.user_uloga = (int)tabela.Rows[0]["uloga"];
                            Korisnik.user_id = (int)tabela.Rows[0]["id"];

                            if (Korisnik.user_uloga == 1)
                            {
                                Response.Redirect("Admin.aspx");
                            }
                            else if (Korisnik.user_uloga == 0)
                            {
                                Response.Redirect("Korisnik.aspx");
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Ovaj korisnik nema ulogu')", true);
                            }
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Pogresan password')", true);
                        }

                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Nepostojeca email adresa')", true);
                    }

                }
                catch (Exception greska)
                {
                    Console.WriteLine(greska.Message);
                }
            }
        }
    }
}