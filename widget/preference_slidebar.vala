using Gtk;
using Widgets;

namespace Widgets {
    public class PreferenceSlidebar : Gtk.Grid {
        public int width = 150;
		public int height = 30;
		
		public signal void click_item(string name);
		
        public PreferenceSlidebar() {
			set_size_request(width, -1);
			
            var basic_segement = new PreferenceSlideItem(this, "Basic", "basic", true);
			this.attach(basic_segement, 0, 0, width, height);
            
            var theme_segement = new PreferenceSlideItem(this, "Theme", "theme", false);
			this.attach_next_to(theme_segement, basic_segement, Gtk.PositionType.BOTTOM, width, height);

            var hotkey_segement = new PreferenceSlideItem(this, "Hotkey", "hotkey", true);
			this.attach_next_to(hotkey_segement, theme_segement, Gtk.PositionType.BOTTOM, width, height);

            var terminal_key_segement = new PreferenceSlideItem(this, "Terminal", "temrinal_key", false);
			this.attach_next_to(terminal_key_segement, hotkey_segement, Gtk.PositionType.BOTTOM, width, height);
            
            var workspace_key_segement = new PreferenceSlideItem(this, "Workspace", "workspace_key", false);
			this.attach_next_to(workspace_key_segement, terminal_key_segement, Gtk.PositionType.BOTTOM, width, height);
            
            var advanced_key_segement = new PreferenceSlideItem(this, "Advanced", "advanced_key", false);
			this.attach_next_to(advanced_key_segement, workspace_key_segement, Gtk.PositionType.BOTTOM, width, height);

            var advanced_segement = new PreferenceSlideItem(this, "Advanced", "advanced", true);
			this.attach_next_to(advanced_segement, advanced_key_segement, Gtk.PositionType.BOTTOM, width, height);
            
            var cursor_segement = new PreferenceSlideItem(this, "Cursor", "cursor", false);
			this.attach_next_to(cursor_segement, advanced_segement, Gtk.PositionType.BOTTOM, width, height);

            var scroll_segement = new PreferenceSlideItem(this, "Scroll", "scroll", false);
			this.attach_next_to(scroll_segement, cursor_segement, Gtk.PositionType.BOTTOM, width, height);

            var window_segement = new PreferenceSlideItem(this, "Window", "window", false);
			this.attach_next_to(window_segement, cursor_segement, Gtk.PositionType.BOTTOM, width, height);
            
            var about_segement = new PreferenceSlideItem(this, "About", "about", true);
			this.attach_next_to(about_segement, window_segement, Gtk.PositionType.BOTTOM, width, height);
            
            show_all();
        }
    }

    public class PreferenceSlideItem : Gtk.EventBox {
        public string item_name;
        public bool item_active;
        public bool is_first_segement;
        
        public int first_segement_margin = 10;
        public int second_segement_margin = 15;
        
        public PreferenceSlideItem(PreferenceSlidebar bar, string display_name, string name, bool is_first) {
			set_visible_window(false);
			
            item_name = display_name;
            is_first_segement = is_first;
            
            set_size_request(150, 22);
			
			button_press_event.connect((w, e) => {
					bar.click_item(name);
					
					return false;
				});
            
            draw.connect(on_draw);
        }
        
        private bool on_draw(Gtk.Widget widget, Cairo.Context cr) {
            Gtk.Allocation rect;
            widget.get_allocation(out rect);
            
            cr.set_source_rgba(1, 1, 1, 1);
            Draw.draw_rectangle(cr, 0, 0, rect.width, rect.height, true);
            
            cr.set_source_rgba(0, 0, 0, 1);
            if (is_first_segement) {
                Draw.draw_text(widget, cr, item_name, first_segement_margin, 0, rect.width - first_segement_margin, rect.height);
            } else {
                Draw.draw_text(widget, cr, item_name, second_segement_margin, 0, rect.width - second_segement_margin, rect.height);
            }
            
            return true;
        }
    }
}