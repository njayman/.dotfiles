import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import { bind, Variable } from "astal";
import Hyprland from "gi://AstalHyprland";

const time = Variable("").poll(1000, "date");

const Clock = () => {
  return (
    <menubutton hexpand halign={Gtk.Align.CENTER}>
      <label label={time()} />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  );
};

const Workspaces = () => {
  const hypr = Hyprland.get_default();

  return (
    <box>
      {bind(hypr, "workspaces").as((wss) =>
        wss
          .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
          .sort((a, b) => a.id - b.id)
          .map((ws) => (
            <button
              cssName={bind(hypr, "focusedWorkspace")
                .as((fw) => (ws === fw ? "focused" : ""))
                .toString()}
              onClicked={() => ws.focus()}
            >
              {ws.id}
            </button>
          )),
      )}
    </box>
  );
};

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox cssName="centerbox">
        <Workspaces />
        <box />
        <Clock />
      </centerbox>
    </window>
  );
}
