/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package restacoef;

import com.honzasterba.dbfcoef.DbCoef;
import java.io.File;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileFilter;

/**
 *
 * @author honza
 */
public class Main {

    static MainUI ui;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        ui = new MainUI();
        ui.setVisible(true);
    }

    public static void work(String path, String coefStr) {
        try {
            float coef = Float.parseFloat(coefStr);
            path = path.replaceAll("\\\\", "/");
            System.out.print("RUN IN " + path + " " + coef);
            DbCoef.run(path, coef);
            showMessage("Hotovo.");
        } catch (NumberFormatException e) {
            showMessage("Koeficient musi byt cislo.");
        } catch (Exception e) {
            showMessage("Chyba: " + e.getMessage());
        }

    }

    public static void findFiles() {
        JFileChooser jfc = new JFileChooser();
        jfc.setDialogTitle("Vyberte umisteni ceniku");
        jfc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        jfc.setFileFilter(new FileFilter() {

            @Override
            public boolean accept(File f) {
                return f.isDirectory();
            }

            @Override
            public String getDescription() {
                return "Pouze adresare";
            }
        });
        int res = jfc.showDialog(ui, "Vybrat");
        if (res == JFileChooser.APPROVE_OPTION) {
            ui.filesField.setText(jfc.getSelectedFile().getAbsolutePath());
        }
    }

    public static void showMessage(String msg) {
        System.out.print("Zprava: " + msg);
        JOptionPane.showMessageDialog(ui, msg);
    }
}
