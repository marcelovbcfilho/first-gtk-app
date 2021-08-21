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

        var button_hello = new Gtk.Button.with_label ("Click me!") {
            margin = 12
        };

        button_hello.clicked.connect (() => {
            button_hello.label = _("Hello World!");
            button_hello.sensitive = false;
        });

        var label = new Gtk.Label (_("Hello Again World!"));

        main_window.add (label);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new MyApp ().run (args);
    }
}
