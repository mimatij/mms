import java.util.ArrayList;
import java.util.List;

//lista pitanja
ArrayList<Pitanje> listaPitanja = new ArrayList();
ArrayList<Pitanje> listaTocnihPitanja = new ArrayList();
int indeksPitanja = 0;
  int tocnoOdg;
int h =0;
int j=1;
ArrayList<Pitanje> pomocnaLista = new ArrayList();

//status programa, opcije:
final int uTijeku=0;
final int kraj=1;
final int odgovorenoPitanje=2;
//trenutni status označavam varijablom status
int status = uTijeku; 

int vrijeme;
int cekaj = 1000;
boolean otkucaj = false;
//sva pitanja spremim u polje
 String[] poljePitanja = {"Kada počinje godišnje doba zima?", "21.12.", "21.3.","21.6.","23.9.", 
                           "Koliko stranica ima geometrijski lik pravokutnik?","2","3","4","5",
                           "Koji je glavni grad Hrvatske?", "Split", "Osijek", "Zadar", "Zagreb", "Kako se zove naše lijepo plavo more?", "Jonsko", "Talijansko", "Baltičko", "Jadransko",
                           "Čudnovate zgode šegrta hlapića napisao/napisala je:", "August Šenoa","Ivana Brlić-Mažuranić", "Dobriša Cesarić", "Marko Marulić",
                           "Grad ne ušću rijeke Cetine je:", "Omiš","Split", "Šibenik","Makarska",
                           "Navijači Hajduka nazivaju se: ", "Bad Blude Boysi", "Kohorta",  "Torcida", "Funcuti",
                           "Sport koji se igra na ledu nazivamo:", "Nogomet", "Košarka", "Plivanje", "Hokej",
                           "Za koju životinju kažemo da je čovjekov vjerni prijatelj?", "Krokodil","Pas","Lav","Zlatna ribica",
                           "Izbaci uljeza! Što od navedenog nije padalina?", "Sijeg", "Kiša", "Mraz", "Sunce",
                           "Koje navedeno voće NE raste na stablu: ", "Lubenica", "Kruška","Jabuka", "Breskva",
                           "Grad u Istri je: ", "Dubrovnik", "Pula","Osijek","Rab",
                           "Koliko 1 sat ima minuta?","30","40","50","60",
                           "U jednadzbi 2x=16, x iznosi:", "4","6","8","10",
                           "Prijevod za 'Good morning' glasi...", "Dobro jutro!", "Dobar dan.", "Dobra večer.", "Laku noć...",
                           "Koja navedena životinja živi u moru:", "žaba", "dupin","ptica","mrav",
                           "Prve piramide izgrađe su u:", "Irskoj","Španjolskoj", "Egiptu", "Kini", 
                           "Što od navedenog nije marka automobila: ", "BMW", "Nokia", "Audi", "Mazda",
                           "Geometrijski lik je trokut a njemu slično geometrijsko tijelo je...", "Kocka","Valjak","Kvadar","Piramida",
                           "Izbaci uljeza među nebeskim tijelima!", "Zvijezda", "Oblak", "Sunce", "Mjesec"
                          };
  int[] tocniOdgovori={1,3,4,4,2,1,3,4,2,4,1,2,4,3,1,2,3,2,4,2};

void setup(){
  size(1024,576);
  vrijeme = millis(); //vraća broj milisekundi proteklih od pokretanja programa
  tocnoOdg=0;

  int i2=0;
  
    for (int i=0; i<poljePitanja.length; i+=5)
    {
      Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 70);
      pomocnaLista.add(trenutnoPitanje); //lista u koju stavljamo sva pitanja
      i2++;
    }
   //za shuffle arrayliste
   // Collections.shuffle(listaPitanja);
   
   while(listaPitanja.size()< 10)
   {
     int indeks = (int)random(pomocnaLista.size());
     listaPitanja.add(pomocnaLista.get(indeks)); //random generira listu pitanja
     pomocnaLista.remove(indeks); //kad izgneneriramo neko pitanje, ne zelimo ga vise ponoviti
    // print(indeks+" ");
   }
    
}

void draw() {
  PImage img;
  img =  loadImage("slikica.png");
  background(img);
  
  int brojTocnihPitanja = listaTocnihPitanja.size();
   int ukupnoPitanja= listaPitanja.size();
  
  
  switch(status) {
    case uTijeku:
      listaPitanja.get(indeksPitanja).display();
      break;
    case odgovorenoPitanje:
      
      //ako je tocno ----- inače ----
      if(listaPitanja.get(indeksPitanja).check(mouseX,mouseY))
      {
       fill(95,26,135);
       textSize(80);
       listaTocnihPitanja.add(listaPitanja.get(indeksPitanja));
       text("Točno", 50,300);
      h=1;
      }
      else
      {
        h=0;
        fill(95,26,135);
        textSize(80);
        text("Netočno", 50,300);
      }
       if(millis()-vrijeme>=cekaj)
      {
      status = uTijeku;
      indeksPitanja++;
      j++;
      otkucaj = true;
      vrijeme = millis();
      if(h==1) tocnoOdg++;
      }
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
       break;
    case kraj:
   
      fill(0);
      textSize(20);
      text("Kviz je završio.Vaš rezultat je "+tocnoOdg+"/"+ukupnoPitanja+".", 100, 300);
      text("Kliknite ENTER za ponovo igranje",100,350);
      j=1;
      
  }
}

void mouseClicked()
{
  switch(status) {
    case uTijeku:
      if(mouseX>=30 && mouseX <=80 && mouseY>=80 && mouseY<=240) 
      {
        status = odgovorenoPitanje;
        vrijeme = millis();
      }
      break;
    case odgovorenoPitanje:
      status = uTijeku;
     // indeksPitanja++;
      if(indeksPitanja>listaPitanja.size()-1)
      {
        status = kraj;
      }
      
      break;
      default:
       break;
  }
}
  
void keyPressed()
{
  switch(status) {
     case kraj:
       if(key==ENTER) {
         indeksPitanja=0;
         status=uTijeku;
         tocnoOdg=0;
         int i2=0;
         
        pomocnaLista= new ArrayList();
        listaPitanja= new ArrayList();
        for (int i=0; i<poljePitanja.length; i+=5)
        {
          Pitanje trenutnoPitanje = new Pitanje(poljePitanja[i], poljePitanja[i+1],poljePitanja[i+2], poljePitanja[i+3],poljePitanja[i+4], tocniOdgovori[i2], 30, 70);
          pomocnaLista.add(trenutnoPitanje);
          i2++;
          }

        while(listaPitanja.size()< 10)
        {
         int indeks = (int)random(9);
         listaPitanja.add(pomocnaLista.get(indeks));
         pomocnaLista.remove(indeks);
       //  print("***size:"+pomocnaLista.size());
       //  print ("***"+indeks);
        }
       }
       break;
     default:
       break;  
  }
  
}

//klasa Pitanje
class Pitanje {
  String tekstPitanja;
  String odg1, odg2, odg3, odg4;
  int tocanOdgovor;
  int pozicijaX, pozicijaY;

  
  Pitanje(String tp, String o1, String o2, String o3, String o4, int tocan, int x, int y)
  {
    tekstPitanja = tp;
    odg1 = o1;
    odg2 = o2;
    odg3 = o3;
    odg4 = o4;
    tocanOdgovor = tocan;
    pozicijaX = x;
    pozicijaY = y;
   // print("***x: "+x);
    tocnoOdg=0;
  }
  void display() {
    fill(102,26,135);
    textSize(30);
    text(""+j+".",pozicijaX-20,pozicijaY);
    text(tekstPitanja, pozicijaX+25, pozicijaY);
    fill(152,22,172);
    textSize(25);
    text(" 1.) "+odg1, pozicijaX, pozicijaY+50);
    text(" 2.) "+odg2, pozicijaX, pozicijaY+90);
    text(" 3.) "+odg3, pozicijaX, pozicijaY+130);
    text(" 4.) "+odg4, pozicijaX, pozicijaY+170);
    fill(236,219,239);
    textSize(16);
    text("Na tipkovnici odaberi broj uz točan odgovor.", pozicijaX, pozicijaY+250);
    text("(Preostalo "+(10-j)+" pitanja.)",pozicijaX, pozicijaY+290);
  }
  
  boolean check(int x_koord,int y_koord) {
    if(x_koord>=30 && x_koord <=80 && y_koord>=90 && y_koord<130 && tocanOdgovor==1)   return true;
    if(x_koord>=30 && x_koord <=80 && y_koord>=130 && y_koord<170 && tocanOdgovor==2)  return true; 
    if(x_koord>=30 && x_koord <=80 && y_koord>=170 && y_koord<210 && tocanOdgovor==3)  return true; 
    if(x_koord>=30 && x_koord <=80 && y_koord>=210 && y_koord<=240 && tocanOdgovor==4)  return true; 
    else
      return false;
  }
  
  
}
