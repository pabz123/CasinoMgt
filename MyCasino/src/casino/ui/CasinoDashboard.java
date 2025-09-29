package casino.ui;

import javax.swing.*;
import java.awt.*;
import java.util.HashMap;

public class CasinoDashboard extends JFrame {

    private final JPanel mainPanel;
    private final HashMap<String, JButton> buttons;

    public CasinoDashboard(String role) {
        setTitle("Casino Dashboard - Role: " + role);
        setSize(600, 500);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        mainPanel = new JPanel(new GridLayout(2, 3, 10,10));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(10, 20, 20, 10));

        buttons = new HashMap<>();

        // Add buttons/icons
        if (role.equalsIgnoreCase("Admin")) {
            addButton("Manage Customers", "👤");
            buttons.get("Manage Customers").addActionListener(e ->{
                CustomerMenu.CustomerMain();
            this.dispose();
            });
            
            addButton("Manage Employees", "🧑‍💼");
             buttons.get("Manage Employees").addActionListener(e ->{
                EmployeeMenu.EmployeeMain();
            this.dispose();
            });
            addButton("Finance Reports", "💵");
            buttons.get("Finance Reports").addActionListener(e ->{ 
                FinanceMenu.FinanceMain();
            this.dispose();
            } );
            addButton("Games", "🎲");
            buttons.get("Games").addActionListener(e -> {
                GameMenu.GameMain();
            this.dispose();
             });
            addButton("Restuarant", "📦");
            buttons.get("Restuarant").addActionListener(e ->{
                  Restuarant.RestuarantMain();
                  this.dispose();
            });
            addButton("Security Logs", "🛡");
            buttons.get("Security Logs").addActionListener(e ->{
                  SecurityLogs.SecurityLogMain();
                  this.dispose();
            });
        } //
        else if (role.equalsIgnoreCase("Cashier")) {
            Cashier.CashierMain();
            this.dispose();
            //addButton("Transactions", "💳");
            //addButton("Payments", "💵");
        } else if (role.equalsIgnoreCase("Security")) {
            Security.SecurityMain();
            this.dispose();
            //addButton("Security Staff", "🛡");
           // addButton("Incidents", "🚨");
        }

        add(mainPanel, BorderLayout.CENTER);
    }

    private void addButton(String text, String iconEmoji) {
        JButton btn = new JButton("<html><center>" + iconEmoji + "<br>" + text + "</center></html>");
        btn.setFont(new Font("Segoe UI", Font.BOLD, 18));
        btn.setBackground(new Color(34, 139, 34));
        btn.setForeground(Color.WHITE);
        btn.setFocusPainted(false);
        mainPanel.add(btn);
        buttons.put(text, btn);
       




    }
}
