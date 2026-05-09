import { createFileRoute } from "@tanstack/react-router";
import { ResumeIntelligence } from "@/components/ResumeIntelligence";

export const Route = createFileRoute("/resume")({
  component: ResumeIntelligence,
});