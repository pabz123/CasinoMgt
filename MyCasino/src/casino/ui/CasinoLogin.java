
package casino.ui;

import casino.db.DBConnection;
import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class CasinoLogin extends JFrame {
    private final JTextField txtUsername;
    private final JPasswordField txtPassword;

    public CasinoLogin() {
        setTitle("Casino Login");
        setSize(600, 400);
        
        setLocationRelativeTo(null);
       

        // Background with casino image
        JPanel bgPanel = new JPanel() {
            private final Image bgImage = new ImageIcon(getClass().getResource("/resources/casino_bg.png")).getImage();

            @Override
            protected void paintComponent(Graphics g) {
                super.paintComponent(g);
                g.drawImage(bgImage, 0, 0, getWidth(), getHeight(), this);
            }
        };
        bgPanel.setLayout(new GridBagLayout());

        // Transparent login panel
        JPanel loginPanel = new JPanel(new GridLayout(4, 2, 10, 10));
        loginPanel.setPreferredSize(new Dimension(320, 200));
        loginPanel.setBackground(new Color(0, 0, 0, 150));
        loginPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        JLabel lblUser = new JLabel("Username:");
        lblUser.setForeground(Color.WHITE);
        txtUsername = new JTextField();

        JLabel lblPass = new JLabel("Password:");
        lblPass.setForeground(Color.WHITE);
        txtPassword = new JPasswordField();

        JButton btnLogin = new JButton("Login");
        styleButton(btnLogin);
        btnLogin.addActionListener(e -> login());

        JButton btnSignup = new JButton("Sign Up");
        styleButton(btnSignup);
        btnSignup.addActionListener(e -> {
            new CasinoSignup().setVisible(true);
        });

        loginPanel.add(lblUser);
        loginPanel.add(txtUsername);
        loginPanel.add(lblPass);
        loginPanel.add(txtPassword);
        loginPanel.add(btnLogin);
        loginPanel.add(btnSignup);

        bgPanel.add(loginPanel);
        add(bgPanel);
    }

    private void styleButton(JButton button) {
        button.setBackground(new Color(34, 139, 34));
        button.setForeground(Color.WHITE);
        button.setFont(new Font("Arial", Font.BOLD, 14));
        button.setFocusPainted(false);

        button.addMouseListener(new java.awt.event.MouseAdapter() {
            @Override
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                button.setBackground(new Color(0, 100, 0));
            }
            @Override
            public void mouseExited(java.awt.event.MouseEvent evt) {
                button.setBackground(new Color(34, 139, 34));
            }
        });
    }

    public void login() {
        String username = txtUsername.getText();
        String password = new String(txtPassword.getPassword());

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT employee_role FROM app_users WHERE username=? AND password_hash=?"
            );
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("employee_role");
                JOptionPane.showMessageDialog(this, "Welcome " + username);
                
                 if (role.equalsIgnoreCase("Admin")) {
                     MainDashboard.MainDashboardMain();
                dispose();
                     
            //addButton("Manage Customers", "👤");
            //buttons.get("Manage Customers").addActionListener(e ->{
               // CustomerMenu.CustomerMain();
           // this.dispose();
            //});
            
           // addButton("Manage Employees", "🧑‍💼");
             //buttons.get("Manage Employees").addActionListener(e ->{
            //    EmployeeMenu.EmployeeMain();
         //   this.dispose();
           // });
           // addButton("Finance Reports", "💵");
           // buttons.get("Finance Reports").addActionListener(e ->{ 
             //   FinanceMenu.FinanceMain();
          //  this.dispose();
          //  } );
            //addButton("Games", "🎲");
            //buttons.get("Games").addActionListener(e -> {
              //  GameMenu.GameMain();
           // this.dispose();
            // });
           // addButton("Restuarant", "📦");
          //  buttons.get("Restuarant").addActionListener(e ->{
               //   Restuarant.RestuarantMain();
                //  this.dispose();
           // });
            //addButton("Security Logs", "🛡");
           // buttons.get("Security Logs").addActionListener(e ->{
                 // SecurityLogs.SecurityLogMain();
                //  this.dispose();
           // });
        } else if (role.equalsIgnoreCase("Cashier")) {
           MainDashboard.MainDashboardMain();
            this.dispose();
            //addButton("Transactions", "💳");
            //addButton("Payments", "💵");
        } else if (role.equalsIgnoreCase("Security")) {
            MainDashboard.MainDashboardMain();
            this.dispose();
            //addButton("Security Staff", "🛡");
           // addButton("Incidents", "🚨");
        }
        else if(role.equalsIgnoreCase("Game Manager")){
        MainDashboard.MainDashboardMain();
        this.dispose();
        }  
         else if(role.equalsIgnoreCase("Restuarant Manager")){
        MainDashboard.MainDashboardMain();
        this.dispose();}  
            } else {
                JOptionPane.showMessageDialog(this, "Invalid login, try again.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }
}
