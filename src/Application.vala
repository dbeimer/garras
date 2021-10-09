/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2021 Beimer Campos <beimercampos.123@gmail.com>
 */

public class MyApp: Gtk.Application{
  
 
  
  public MyApp(){
    Object(
        application_id:"com.github.dbeimer.garras",
        flags:ApplicationFlags.FLAGS_NONE
      );
  }

  protected override void activate(){
    Hdy.init();
    //activando el dark mode
    var granite_settings=Granite.Settings.get_default();
    var gtk_settings=Gtk.Settings.get_default();

    gtk_settings.gtk_application_prefer_dark_theme=granite_settings.prefers_color_scheme==Granite.Settings.ColorScheme.DARK;
    granite_settings.notify["prefers_color_scheme"].connect(()=>{
      gtk_settings.gtk_application_prefer_dark_theme=granite_settings.prefers_color_scheme==Granite.Settings.ColorScheme.DARK; 
    }); 

    var header=new Hdy.HeaderBar(){
      show_close_button=true
    };

    header.title="Garras";


    var main_window=new Hdy.ApplicationWindow(){
      default_height=300,
      default_width=500,
      application=this,
      title="Garras"
    };


    //listbox
    var lista=new Gtk.ListBox();

    var button_hello=new Gtk.Button.with_label("Add"){
    };

    var main_grid=new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
    var first_row=new Gtk.Box(Gtk.Orientation.HORIZONTAL,6);
    first_row.margin=12;

    var txt_new_value=new Gtk.Entry();

    first_row.add(txt_new_value);
    first_row.add(button_hello);

    main_grid.add(header);
    main_grid.add(first_row);
    main_grid.add(lista);


    button_hello.clicked.connect(()=>{
      if (txt_new_value.text!=null&&txt_new_value.text!=""){
        var item_row=new Gtk.Box(Gtk.Orientation.HORIZONTAL,6);
        item_row.margin=6;
        item_row.add(new Gtk.Label(txt_new_value.text){margin=6});
        item_row.add(new Gtk.Button.from_icon_name("edit-delete",Gtk.IconSize.BUTTON));

        lista.add(item_row);
      }
      txt_new_value.text="";
      txt_new_value.is_focus=true;
      lista.show_all();
    });

    // main_window.add(label);
    // main_window.set_titlebar(header);
    main_window.add(main_grid);
    main_window.show_all();


  }

  public static int main(string[] args){


    Sqlite.Database db;
    string errmsg;

    int ec=Sqlite.Database.open("garras.db",out db);
    if(ec!=Sqlite.OK){
      stderr.printf("Can't open database: %d: %s\n",db.errcode(),db.errmsg());
      return -1;
    }

    return new MyApp().run(args);
  }
}
