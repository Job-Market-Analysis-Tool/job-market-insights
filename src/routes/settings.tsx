import { createFileRoute } from "@tanstack/react-router";
import { PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/settings")({
  component: SettingsPage,
});

function SettingsPage() {
  return (
    <div>
      <PageHeader title="Settings" subtitle="Manage your profile and preferences." />
      <div className="max-w-xl space-y-4 rounded-xl border border-border bg-card p-6">
        <div>
          <label className="mb-1 block text-sm text-muted-foreground">Full Name</label>
          <input
            defaultValue="Masab Haroon"
            className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm text-foreground outline-none focus:border-primary"
          />
        </div>
        <div>
          <label className="mb-1 block text-sm text-muted-foreground">Email</label>
          <input
            defaultValue="masab@example.com"
            className="w-full rounded-md border border-border bg-background px-3 py-2 text-sm text-foreground outline-none focus:border-primary"
          />
        </div>
        <button className="rounded-md bg-primary px-4 py-2 text-sm font-semibold text-primary-foreground hover:opacity-90">
          Save Changes
        </button>
      </div>
    </div>
  );
}
