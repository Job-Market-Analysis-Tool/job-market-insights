import { createFileRoute } from "@tanstack/react-router";
import { PageHeader } from "@/components/PageHeader";
import { TrendingUp } from "lucide-react";

export const Route = createFileRoute("/market-trends")({
  component: MarketTrends,
});

const trends = [
  { tag: "AI / LLM", growth: "+142%" },
  { tag: "TypeScript", growth: "+38%" },
  { tag: "Rust", growth: "+61%" },
  { tag: "DevOps", growth: "+24%" },
];

function MarketTrends() {
  return (
    <div>
      <PageHeader
        title="Market Trends"
        subtitle="Hottest skills and roles across the job market."
      />
      <div className="grid gap-4 md:grid-cols-2">
        {trends.map((t) => (
          <div
            key={t.tag}
            className="flex items-center justify-between rounded-xl border border-border bg-card p-5"
          >
            <span className="font-medium text-foreground">{t.tag}</span>
            <span className="flex items-center gap-1 text-success">
              <TrendingUp className="h-4 w-4" />
              <span className="font-semibold">{t.growth}</span>
            </span>
          </div>
        ))}
      </div>
    </div>
  );
}
