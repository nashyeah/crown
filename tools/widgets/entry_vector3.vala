/*
 * Copyright (c) 2012-2020 Daniele Bartolini and individual contributors.
 * License: https://github.com/dbartolini/crown/blob/master/LICENSE
 */

using Gtk;

namespace Crown
{
	public class EntryVector3 : Gtk.Box
	{
		// Data
		public bool _stop_emit;

		// Widgets
		public EntryDouble _x;
		public EntryDouble _y;
		public EntryDouble _z;

		public Vector3 value
		{
			get
			{
				return Vector3(_x.value, _y.value, _z.value);
			}
			set
			{
				_stop_emit = true;
				Vector3 val = (Vector3)value;
				_x.value = val.x;
				_y.value = val.y;
				_z.value = val.z;
				_stop_emit = false;
			}
		}

		// Signals
		public signal void value_changed();

		public EntryVector3(Vector3 xyz, Vector3 min, Vector3 max, string fmt)
		{
			Object(orientation: Gtk.Orientation.HORIZONTAL, spacing: 0);

			// Data
			_stop_emit = false;

			// Widgets
			_x = new EntryDouble(xyz.x, min.x, max.x, fmt);
			_y = new EntryDouble(xyz.y, min.y, max.y, fmt);
			_z = new EntryDouble(xyz.z, min.z, max.z, fmt);

			_x.value_changed.connect(on_value_changed);
			_y.value_changed.connect(on_value_changed);
			_z.value_changed.connect(on_value_changed);

			add(_x);
			add(_y);
			add(_z);
		}

		private void on_value_changed()
		{
			if (!_stop_emit)
				value_changed();
		}
	}
}
