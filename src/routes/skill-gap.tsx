import { createFileRoute } from "@tanstack/react-router";
import { PieChart, Pie, Cell, ResponsiveContainer } from "recharts";
import { CheckCircle2, XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/skill-gap")({
  component: SkillGap,
});

const skillsHave = [
  "Network Security",
  "Python Programming",
  "Incident Response",
  "Threat Analysis",
  "Linux Administration",
  "Security Auditing",
];

const skillsAcquire = [
  "Cloud Security (AWS)",
  "Zero Trust Architecture",
  "Container Security",
  "Security Automation",
  "Compliance Frameworks",
  "Advanced Cryptography",
];

const donutData = [
  { name: "Matched", value: 78 },
  { name: "Gap", value: 22 },
];
const DONUT_COLORS = ["#00D4FF", "#1F2937"];

function SkillGap() {
  return (
    <div className="space-y-8">
      {/* Top bar */}
      <div className="flex flex-wrap items-start justify-between gap-4 border-b border-border pb-6">
        <div>
          <h1 className="text-2xl font-bold text-primary">Virtual Job Market Analysis</h1>
          <p className="mt-1 text-xs uppercase tracking-widest text-muted-foreground">
            Cybersecurity Career Intelligence System
          </p>
        </div>
        <div className="flex items-center gap-4 text-xs uppercase tracking-widest">
          <span className="flex items-center gap-2 rounded-full border border-success/30 bg-success/10 px-3 py-1 text-success">
            <span className="h-2 w-2 animate-pulse rounded-full bg-success" />
            Live Analysis
          </span>
          <span className="text-muted-foreground">Updated: 2m ago</span>
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-5">
        {/* LEFT COLUMN 40% */}
        <div className="lg:col-span-2 rounded-xl border border-border bg-card p-6">
          <p className="text-xs font-semibold uppercase tracking-widest text-primary">
            ● Module 5.1 // Skill Analysis
          </p>
          <div className="relative mt-6 h-64">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie
                  data={donutData}
                  innerRadius={80}
                  outerRadius={110}
                  startAngle={90}
                  endAngle={-270}
                  dataKey="value"
                  stroke="none"
                >
                  {donutData.map((_, i) => (
                    <Cell key={i} fill={DONUT_COLORS[i]} />
                  ))}
                </Pie>
              </PieChart>
            </ResponsiveContainer>
            <div className="pointer-events-none absolute inset-0 flex flex-col items-center justify-center">
              <span className="text-5xl font-bold text-primary">78%</span>
              <span className="mt-1 text-xs uppercase tracking-widest text-muted-foreground">
                Skill Match
              </span>
            </div>
          </div>
          <div className="mt-6 flex items-center justify-center gap-6 text-xs uppercase tracking-widest">
            <span className="flex items-center gap-2 text-muted-foreground">
              <span className="h-2.5 w-2.5 rounded-full bg-success" />
              Matched Skills
            </span>
            <span className="flex items-center gap-2 text-muted-foreground">
              <span className="h-2.5 w-2.5 rounded-full bg-border" />
              Skill Gap
            </span>
          </div>
        </div>

        {/* RIGHT COLUMN 60% */}
        <div className="lg:col-span-3 rounded-xl border border-border bg-card p-6">
          <p className="text-xs font-semibold uppercase tracking-widest text-primary">
            ● Module 5.2 // Skill Comparison
          </p>
          <div className="mt-6 grid gap-6 md:grid-cols-2">
            {/* Have */}
            <div>
              <div className="mb-3 flex items-center gap-2 text-sm font-semibold text-success">
                <CheckCircle2 className="h-4 w-4" />
                SKILLS YOU HAVE
              </div>
              <div className="space-y-2">
                {skillsHave.map((s) => (
                  <div
                    key={s}
                    className="rounded-md border-l-4 border-success bg-background/60 px-3 py-2 text-sm text-foreground transition-shadow hover:shadow-[0_0_14px_rgba(0,255,136,0.35)]"
                  >
                    {s}
                  </div>
                ))}
              </div>
            </div>
            {/* Acquire */}
            <div>
              <div className="mb-3 flex items-center gap-2 text-sm font-semibold text-destructive">
                <XCircle className="h-4 w-4" />
                SKILLS TO ACQUIRE
              </div>
              <div className="space-y-2">
                {skillsAcquire.map((s) => (
                  <div
                    key={s}
                    className="rounded-md border-l-4 border-destructive bg-background/60 px-3 py-2 text-sm text-foreground transition-shadow hover:shadow-[0_0_14px_rgba(255,68,68,0.35)]"
                  >
                    {s}
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="flex justify-center">
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          Generate Learning Roadmap
        </Button>
      </div>
    </div>
  );
}
