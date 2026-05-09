import { createFileRoute } from "@tanstack/react-router";
import { Check, ArrowRight, ExternalLink, Download } from "lucide-react";
import { Button } from "@/components/ui/button";

export const Route = createFileRoute("/roadmap")({
  component: Roadmap,
});

type Status = "completed" | "in-progress" | "upcoming" | "future";

interface Step {
  title: string;
  skills: string[];
  courses?: { name: string }[];
  status: Status;
}

const steps: Step[] = [
  {
    title: "Foundation Skills",
    skills: ["Python", "Linux", "Network Security"],
    status: "completed",
  },
  {
    title: "Cloud Security Specialization",
    skills: ["AWS Security", "Cloud Architecture", "IAM"],
    courses: [{ name: "AWS Certified Security Specialty" }],
    status: "in-progress",
  },
  {
    title: "Zero Trust Implementation",
    skills: ["Zero Trust Architecture", "Container Security"],
    courses: [{ name: "CISA Zero Trust certification" }],
    status: "upcoming",
  },
  {
    title: "Advanced Threat Response",
    skills: ["Security Automation", "Compliance Frameworks"],
    status: "future",
  },
];

const badgeStyles: Record<Status, string> = {
  completed: "bg-success/15 text-success border-success/30",
  "in-progress": "bg-primary/15 text-primary border-primary/30",
  upcoming: "bg-muted text-muted-foreground border-border",
  future: "bg-muted text-muted-foreground border-border",
};

const badgeLabel: Record<Status, string> = {
  completed: "COMPLETED",
  "in-progress": "IN PROGRESS",
  upcoming: "UPCOMING",
  future: "FUTURE",
};

function Node({ status }: { status: Status }) {
  if (status === "completed") {
    return (
      <div className="flex h-10 w-10 items-center justify-center rounded-full bg-success text-background shadow-[0_0_14px_rgba(0,255,136,0.5)]">
        <Check className="h-5 w-5" strokeWidth={3} />
      </div>
    );
  }
  if (status === "in-progress") {
    return (
      <div className="flex h-10 w-10 items-center justify-center rounded-full bg-primary text-background shadow-[0_0_14px_rgba(0,212,255,0.6)]">
        <ArrowRight className="h-5 w-5" strokeWidth={3} />
      </div>
    );
  }
  return <div className="h-10 w-10 rounded-full border-2 border-border bg-card" />;
}

function connectorClass(prev: Status): string {
  // line above each step (except first), styled by previous step's status
  if (prev === "completed") return "bg-success";
  if (prev === "in-progress")
    return "bg-gradient-to-b from-primary to-border";
  return "border-l-2 border-dashed border-border bg-transparent";
}

function Roadmap() {
  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-2xl font-bold text-foreground">Career Progression Roadmap</h1>
        <p className="mt-1 text-sm text-primary">
          AI-generated path to your target role: Senior Cybersecurity Engineer
        </p>
      </div>

      <div className="mx-auto max-w-2xl">
        {steps.map((step, i) => (
          <div key={step.title} className="relative flex gap-5">
            {/* Timeline column */}
            <div className="flex w-10 flex-col items-center">
              {/* Top connector */}
              {i > 0 ? (
                <div className={`w-[2px] flex-none ${connectorClass(steps[i - 1].status)}`} style={{ height: 28 }} />
              ) : (
                <div style={{ height: 28 }} />
              )}
              <Node status={step.status} />
              {/* Bottom connector grows */}
              {i < steps.length - 1 ? (
                <div className={`w-[2px] flex-1 ${connectorClass(step.status)}`} />
              ) : null}
            </div>

            {/* Card */}
            <div className="flex-1 pb-10">
              <div className="rounded-xl border border-border bg-card p-5">
                <div className="flex items-start justify-between gap-3">
                  <h3 className="text-lg font-semibold text-foreground">{step.title}</h3>
                  <span
                    className={`rounded-full border px-2.5 py-1 text-[10px] font-semibold tracking-widest ${badgeStyles[step.status]}`}
                  >
                    {badgeLabel[step.status]}
                  </span>
                </div>

                <div className="mt-3 flex flex-wrap gap-2">
                  {step.skills.map((s) => (
                    <span
                      key={s}
                      className="rounded-md border border-border bg-background px-2 py-1 text-xs text-muted-foreground"
                    >
                      {s}
                    </span>
                  ))}
                </div>

                {step.courses && (
                  <div className="mt-4 space-y-1.5">
                    <p className="text-xs uppercase tracking-widest text-muted-foreground">
                      Recommended courses
                    </p>
                    {step.courses.map((c) => (
                      <a
                        key={c.name}
                        href="#"
                        className="inline-flex items-center gap-1.5 text-sm text-primary hover:underline"
                      >
                        {c.name}
                        <ExternalLink className="h-3.5 w-3.5" />
                      </a>
                    ))}
                  </div>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="flex flex-wrap justify-center gap-3">
        <Button variant="outline" className="border-primary text-primary hover:bg-primary/10 hover:text-primary">
          <Download className="h-4 w-4" />
          Download Roadmap PDF
        </Button>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          Start Learning
        </Button>
      </div>
    </div>
  );
}