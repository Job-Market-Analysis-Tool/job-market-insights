import { createFileRoute } from "@tanstack/react-router";
import { PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/skill-gap")({
  component: SkillGap,
});

const skills = [
  { name: "React", level: 95, status: "matched" },
  { name: "TypeScript", level: 88, status: "matched" },
  { name: "Node.js", level: 72, status: "matched" },
  { name: "GraphQL", level: 35, status: "gap" },
  { name: "Kubernetes", level: 20, status: "gap" },
  { name: "AWS", level: 50, status: "warning" },
] as const;

const colorFor = (s: string) =>
  s === "matched" ? "bg-success" : s === "gap" ? "bg-destructive" : "bg-warning";

function SkillGap() {
  return (
    <div>
      <PageHeader
        title="Skill Gap Analysis"
        subtitle="Compare your skills against in-demand requirements."
      />
      <div className="space-y-4 rounded-xl border border-border bg-card p-6">
        {skills.map((s) => (
          <div key={s.name}>
            <div className="mb-1 flex justify-between text-sm">
              <span className="font-medium text-foreground">{s.name}</span>
              <span className="text-muted-foreground">{s.level}%</span>
            </div>
            <div className="h-2 overflow-hidden rounded-full bg-background">
              <div
                className={`h-full ${colorFor(s.status)}`}
                style={{ width: `${s.level}%` }}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
