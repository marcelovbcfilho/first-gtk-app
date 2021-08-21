/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Marcelo Vilas Boas Correa Filho <marcelovbcfilho@gmail.com>
 */

public class MyApp : Gtk.Application {
    public MyApp () {
        Object (
            application_id: "com.github.marcelovbcfilho.gtk-hello",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = _("Hello World")
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

        var grid = new Gtk.Grid () {
            column_spacing = 6,
            row_spacing = 6
        };

        // add first row of widgets
        grid.attach (hello_button, 0, 0, 1, 1);
        grid.attach_next_to (hello_label, hello_button, Gtk.PositionType.RIGHT, 1, 1);

        // add second row of widgets
        grid.attach (rotate_button, 0, 1);
        grid.attach_next_to (rotate_label, rotate_button, Gtk.PositionType.RIGHT, 1, 1);

        main_window.add (grid);

        hello_button.clicked.connect (() => {
            hello_label.label = _("Hello World!");
            hello_button.sensitive = false;
        });
        
        rotate_button.clicked.connect (() => {
            rotate_label.angle = 90;
            rotate_label.label = _("Vertical");
            rotate_button.sensitive = false;
        });

        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
