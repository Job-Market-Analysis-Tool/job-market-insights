import { createFileRoute } from "@tanstack/react-router";
import { PageHeader } from "@/components/PageHeader";
import { FileText, Upload, CheckCircle2, AlertTriangle } from "lucide-react";

export const Route = createFileRoute("/")({
  component: Index,
});

function Index() {
  return (
    <div>
      <PageHeader
        title="Resume Intelligence"
        subtitle="Upload your resume to extract skills, experience and insights."
      />
      <div className="grid gap-6 md:grid-cols-3">
        <div className="rounded-xl border border-border bg-card p-6">
          <div className="mb-3 flex items-center gap-2 text-primary">
            <FileText className="h-5 w-5" />
            <span className="text-sm font-medium">Parsed Resume</span>
          </div>
          <p className="text-3xl font-bold">12</p>
          <p className="text-xs text-muted-foreground">Sections detected</p>
        </div>
        <div className="rounded-xl border border-border bg-card p-6">
          <div className="mb-3 flex items-center gap-2 text-success">
            <CheckCircle2 className="h-5 w-5" />
            <span className="text-sm font-medium">Matched Skills</span>
          </div>
          <p className="text-3xl font-bold">28</p>
          <p className="text-xs text-muted-foreground">Aligned with market</p>
        </div>
        <div className="rounded-xl border border-border bg-card p-6">
          <div className="mb-3 flex items-center gap-2 text-warning">
            <AlertTriangle className="h-5 w-5" />
            <span className="text-sm font-medium">Improvements</span>
          </div>
          <p className="text-3xl font-bold">5</p>
          <p className="text-xs text-muted-foreground">Suggested edits</p>
        </div>
      </div>

      <div className="mt-8 rounded-xl border border-dashed border-border bg-card/40 p-10 text-center">
        <Upload className="mx-auto mb-3 h-8 w-8 text-primary" />
        <p className="text-sm font-medium text-foreground">
          Drop your resume here or click to upload
        </p>
        <p className="mt-1 text-xs text-muted-foreground">
          PDF, DOCX up to 5MB
        </p>
      </div>
    </div>
  );
}
