/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Marcelo Vilas Boas Correa Filho <marcelovbcfilho@gmail.com>
 */

public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.marcelovbcfilho.first-gtk-app",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit",  {"<Control>q", "<Control>w"});

        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = _("First gtk app")
        };

        //  var grid = new Gtk.Grid () {
        //      orientation = Gtk.Orientation.VERTICAL,
        //      row_spacing = 6
        //  };

        //  var button_hello = new Gtk.Button.with_label ("Click me!") {
        //      margin = 12
        //  };

        //  grid.add (new Gtk.Label (_("Label 1")));
        //  grid.add (new Gtk.Label (_("Label 2")));
        //  grid.add (button_hello);

        //  button_hello.clicked.connect (() => {
        //      button_hello.label = _("Hello World!");
        //      button_hello.sensitive = false;
        //  });

        var hello_button = new Gtk.Button.with_label (_("Say Hello"));
        var hello_label = new Gtk.Label (null);

        var rotate_button = new Gtk.Button.with_label (_("Rotate"));
        var rotate_label = new Gtk.Label (_("Horizontal"));

        var send_notification_button = new Gtk.Button.with_label (_("Notify"));
        var replace_notification_button = new Gtk.Button.with_label (_("Replace notification"));

        var grid = new Gtk.Grid () {
            column_spacing = 6,
            row_spacing = 6
        };
    
        var headerbar = new Gtk.HeaderBar () {
            has_subtitle = false,
            show_close_button = true
        };

        var button = new Gtk.Button.from_icon_name ("process-stop", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.quit",
            tooltip_markup = Granite.markup_accel_tooltip (
                get_accels_for_action ("app.quit"),
                "Quit"
            )
        };
        
        headerbar.add (button);

        grid.attach (send_notification_button, 1, 1, 1, 1);
        grid.attach (replace_notification_button, 2, 1, 1, 1);

        // add first row of widgets
        grid.attach (hello_button, 0, 1, 1, 1);
        grid.attach_next_to (hello_label, hello_button, Gtk.PositionType.RIGHT, 1, 1);

        // add second row of widgets
        grid.attach (rotate_button, 0, 2);
        grid.attach_next_to (rotate_label, rotate_button, Gtk.PositionType.RIGHT, 1, 1);

        main_window.add (grid);
        main_window.set_titlebar (headerbar);

        hello_button.clicked.connect (() => {
            hello_label.label = _("Hello World!");
            hello_button.sensitive = false;
        });
        
        rotate_button.clicked.connect (() => {
            rotate_label.angle = 90;
            rotate_label.label = _("Vertical");
            rotate_button.sensitive = false;
        });

        send_notification_button.clicked.connect (() => {
            var notification = new Notification (_("Hello World"));
            notification.set_icon (new ThemedIcon ("process-completed"));
            notification.set_body (_("This is my first notification!"));
            notification.add_button (_("Quit"), "app.quit");
            notification.set_priority (NotificationPriority.URGENT);
        
            send_notification ("com.github.marcelovbcfilho.first-gtk-app", notification);
        });

        replace_notification_button.clicked.connect (() => {
            var notification = new Notification (_("Replacing"));
            notification.set_icon (new ThemedIcon ("process-completed"));
            notification.set_body (_("Replace old notification content!"));
            notification.add_button (_("Quit"), "app.quit");
            notification.set_priority (NotificationPriority.LOW);
        
            send_notification ("com.github.marcelovbcfilho.first-gtk-app", notification);
        });

        // Dock badge
        Granite.Services.Application.set_badge_visible.begin (true);
        Granite.Services.Application.set_badge.begin (100);

        // Charging bar
        Granite.Services.Application.set_progress_visible.begin (true);
        Granite.Services.Application.set_progress.begin (0.2f);

        main_window.show_all ();

        quit_action.activate.connect (() => {
            main_window.destroy ();
        });
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
