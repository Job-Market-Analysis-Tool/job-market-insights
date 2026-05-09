import { createFileRoute } from "@tanstack/react-router";
import { PageHeader } from "@/components/PageHeader";

export const Route = createFileRoute("/job-matching")({
  component: JobMatching,
});

const jobs = [
  { title: "Senior Frontend Engineer", company: "Acme Corp", match: 92 },
  { title: "Full Stack Developer", company: "Globex", match: 87 },
  { title: "React Engineer", company: "Initech", match: 78 },
  { title: "UI Engineer", company: "Umbrella", match: 71 },
];

function JobMatching() {
  return (
    <div>
      <PageHeader
        title="Job Matching"
        subtitle="Best-fit roles based on your resume and skills."
      />
      <div className="space-y-3">
        {jobs.map((j) => (
          <div
            key={j.title}
            className="flex items-center justify-between rounded-xl border border-border bg-card p-5"
          >
            <div>
              <p className="font-semibold text-foreground">{j.title}</p>
              <p className="text-sm text-muted-foreground">{j.company}</p>
            </div>
            <div className="text-right">
              <p className="text-2xl font-bold text-success">{j.match}%</p>
              <p className="text-xs text-muted-foreground">match</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
