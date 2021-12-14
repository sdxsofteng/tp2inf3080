import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class Main {

    final static String MESSAGE_ACCUEIL = "Bienvenue au programme de gestion de la base de donnée pour les élections.";
    final static String DEMANDE_ID_COMTE = "Entrez ID Comté: ";
    final static String DEMANDE_ID_STATION = "Entrez ID Station: ";
    final static String ERREURE_STATION_NON_TROUVEE = "Station invalide! Veuillez recommencer.";
    final static String DEBUT_TABLEAU = "---------------------------------------------------\n"
            +"| ID |      NOM      |   PRENOM   | PARTI | VOTES |\n"
            +"---------------------------------------------------\n" ;
    final static String LIGNE_HORIZONTALE_TABLEAU = "---------------------------------------------------\n";
    final static String TABLEAU_VIDE = "|        AUCUN CANDIDAT DANS CETTE STATION.       |\n";
    final static String PRESENTATION_TABLEAU = "\nLISTE DES CANDIDATS DANS: \nStation: %s\nComté: %s\n";
    final static String AUCUN_CANDIDAT_ENTREE = "Aucun candidat dans cette station/compté. Fin du programme.";

    static int idComte = 0;
    static int idStation = 0;
    static boolean fin = false;
    static ArrayList<Insertion> valuesAInserer = new ArrayList<>();


    public static void main(String[] args) {
        JSch jsch = new JSch();
        Session session;
        Connection con;
        try {
            jsch.setKnownHosts("~/.ssh/known_hosts");
            //jsch.addIdentity("~/.ssh/id_rsa");

            session = jsch.getSession("hc191914", "zeta2.labunix.uqam.ca");
            session.setPassword(">MFWyp9^dU.RXXn9PFAXeZMs");
            session.connect();

            int newPort = session.setPortForwardingL(0, "localhost", 1521);

            final String url = "jdbc:oracle:thin:@localhost:" + newPort + ":BACLAB";
            final String dbuser = "hc191914";
            final String dbpass = "JHCEIcms";
            try {
                con = DriverManager.getConnection(url, dbuser, dbpass);

                do {
                    System.out.println(MESSAGE_ACCUEIL);
                    takeUserInput(con);
                    afficherTableauCandidat(con);
                    afficherCandidatParCandidat(con);
                    envoyerResultats(con);
                }while (!fin);
                con.close();
                session.disconnect();

            } catch (SQLException e) {
                //con.close();
                session.disconnect();
                e.printStackTrace();
            }
        } catch (JSchException e) {
            e.printStackTrace();
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    public static void envoyerResultats(Connection con) throws SQLException{
        char input;
        char input2;
        Scanner sc = new Scanner(System.in);
        System.out.print("Confirmer vos entrées (o ou n)?: ");
        input = sc.next().charAt(0);
        while (!(input == 'o' || input == 'n')){
            System.out.println("Choix invalide! Recommencez!");
            System.out.print("Confirmer vos entrées (o ou n)?: ");
            input = sc.next().charAt(0);
        }
        if (input == 'o'){
            fin = true;
            Statement st1 = con.createStatement();
            for (Insertion e: valuesAInserer) {
                st1.executeQuery("insert into comptevotes values(" + e.nombresdevotes + ", "
                        + e.idCandidat + ", " + idStation + ", " + idComte + ")");
            }
            System.out.print("Finaliser les résultats (o ou n)?: ");
            input2 = sc.next().charAt(0);
            while (!(input2 == 'o' || input2 == 'n')){
                System.out.println("Choix invalide! Recommencez!");
                System.out.print("Finaliser les résultats(o ou n)?: ");
                input2 = sc.next().charAt(0);
            }
            if (input == 'o'){
                Statement st2 = con.createStatement();

                Date date = new Date(System.currentTimeMillis());
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                String strdate = formatter.format(date);
                //TODO
                st2.executeQuery("update station set heureenvoivotes = \"" + strdate + "\" where comteid = "
                        + idComte + " and idstation = " + idStation + ";" );

                System.out.print("Quitter le programme (o ou n)?");
                input = sc.next().charAt(0);
                while (!(input == 'o' || input == 'n')) {
                    System.out.println("Choix invalide! Recommencez!");
                    System.out.print("Quitter le programme (o ou n)?: ");
                    input = sc.next().charAt(0);
                }
                if (input == 'o'){
                    fin = true;
                }
            }
        }else {
            valuesAInserer = new ArrayList<>();
            System.out.print("Quitter le programme (o ou n)?");
            input = sc.next().charAt(0);
            while (!(input == 'o' || input == 'n')) {
                System.out.println("Choix invalide! Recommencez!");
                System.out.print("Quitter le programme (o ou n)?: ");
                input = sc.next().charAt(0);
            }
            if (input == 'o'){
                fin = true;
            }
        }
    }

    public static void afficherCandidatParCandidat(Connection con) throws SQLException{
        //Requete de base pour aller chercher le tableau de candidat pour la station.
        Statement st0 = con.createStatement();
        ResultSet candStation = st0.executeQuery("select * from candidat where comteid = " + idComte);
        if (!candStation.next()){
            System.out.print(AUCUN_CANDIDAT_ENTREE);
        }else{
            do {
                Scanner inputUser = new Scanner(System.in);
                int nombreDeVotes = 0;
                int nombreDeVotesEntres;
                int idCandidatCourant = candStation.getInt("idcandidat");
                Statement st1 = con.createStatement();
                ResultSet nbVotes = st1.executeQuery("select nombresdevotes from comptevotes where idcandidat = "
                        + idCandidatCourant + " and idstation = " + idStation + " and comteid = " + idComte);
                if (nbVotes.next()){
                    do {
                        nombreDeVotes += nbVotes.getInt("nombresdevotes");
                    }while (nbVotes.next());
                }
                System.out.printf("Candidat:(%s) %s, %s (ID: %d). Nombre de vote courant: %d \n",
                        candStation.getString("abbreviationparti"),
                        candStation.getString("nomcandidat"),
                        candStation.getString("prenomcandidat"),
                        candStation.getInt("idcandidat"),
                        nombreDeVotes);
                System.out.print("Entrez le nombre de votes à ajouter: ");
                nombreDeVotesEntres = inputUser.nextInt();
                while (nombreDeVotesEntres <= 0){
                    System.out.print("Erreure! Le nombre de vote entré doit être supérieur à 0!\n");
                    System.out.print("Entrez le nombre de votes à ajouter: ");
                    nombreDeVotesEntres = inputUser.nextInt();
                }

                valuesAInserer.add(new Insertion(idCandidatCourant, nombreDeVotesEntres));
            }while (candStation.next());
        }
    }

    public static void afficherTableauCandidat(Connection con) throws SQLException{
        //Chercher le nom de la station
        Statement st0 = con.createStatement();
        ResultSet nomStation = st0.executeQuery("select * from station where comteid = " + idComte
                + " and idstation = " + idStation);
        nomStation.next();

        //Chercher le nom du comté
        Statement st1 = con.createStatement();
        ResultSet nomComte = st1.executeQuery("select * from comte where comteid =" + idComte);
        nomComte.next();

        //Afficher debut tableau
        System.out.printf(PRESENTATION_TABLEAU,
                nomStation.getString("nomstation"),
                nomComte.getString("nomcomte"));
        System.out.print(DEBUT_TABLEAU);

        //Requete de base pour aller chercher le tableau de candidat pour la station.
        Statement st2 = con.createStatement();
        ResultSet candStation = st2.executeQuery("select * from candidat where comteid = " + idComte);

        //Verifer si result set est vide si vide, afficher tableau vide.
        if (!candStation.next()){
            System.out.print(TABLEAU_VIDE);
            System.out.print(LIGNE_HORIZONTALE_TABLEAU);
        }else{
            processValeursCandidats(con, candStation);
        }
    }

    public static void processValeursCandidats(Connection con, ResultSet candStation) throws SQLException{
        do {
            int nombreDeVotes = 0;
            int idCandidatCourant = candStation.getInt("idcandidat");
            //Iterer a travers le nombre de vote par candidats.
            Statement st0 = con.createStatement();
            ResultSet nbVotes = st0.executeQuery("select nombresdevotes from comptevotes where idcandidat = "
                    + idCandidatCourant + " and idstation = " + idStation + " and comteid = " + idComte);
            if (nbVotes.next()){
                do {
                    nombreDeVotes += nbVotes.getInt("nombresdevotes");
                }while (nbVotes.next());
            }

            System.out.printf("| %-2d |   %-10s  | %-11s|  %-2s   | %-5d |\n",
                    candStation.getInt("idcandidat"),
                    candStation.getString("nomcandidat"),
                    candStation.getString("prenomcandidat"),
                    candStation.getString("abbreviationparti"),
                    nombreDeVotes
            );
            System.out.print(LIGNE_HORIZONTALE_TABLEAU);

        } while (candStation.next());
    }

    public static void takeUserInput(Connection con) throws SQLException{
        Scanner sc = new Scanner(System.in);
        boolean valide = false;

        do {
            //Demande à l'utilisateur
            System.out.print(DEMANDE_ID_COMTE);
            idComte = sc.nextInt();
            System.out.print(DEMANDE_ID_STATION);
            idStation = sc.nextInt();

            //Vérification si idComte et idStation pointe vers une station
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from station where comteid = " + idComte
                    + " and idstation = " +idStation);

            //Verifier si le retour est vide, si vide message erreur et recommencer sinon continuer
            if (!rs.next()){
                System.out.println(ERREURE_STATION_NON_TROUVEE);
            }else{
                valide = true;
            }
        }while(!valide);

    }
}
