import { useRef, useState, type DragEvent, type ChangeEvent } from "react";
import { useNavigate } from "@tanstack/react-router";
import { Sparkles, Upload, FileIcon, Loader2 } from "lucide-react";

const ACCEPT = ".pdf,.doc,.docx";
const MAX_BYTES = 10 * 1024 * 1024;

function formatSize(bytes: number) {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(1)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(2)} MB`;
}

export function ResumeIntelligence() {
  const navigate = useNavigate();
  const inputRef = useRef<HTMLInputElement>(null);
  const [file, setFile] = useState<File | null>(null);
  const [dragging, setDragging] = useState(false);
  const [analyzing, setAnalyzing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleFiles = (files: FileList | null) => {
    if (!files || files.length === 0) return;
    const f = files[0];
    const ext = f.name.split(".").pop()?.toLowerCase();
    if (!ext || !["pdf", "doc", "docx"].includes(ext)) {
      setError("Only PDF, DOC, or DOCX files are accepted.");
      return;
    }
    if (f.size > MAX_BYTES) {
      setError("File exceeds 10MB limit.");
      return;
    }
    setError(null);
    setFile(f);
  };

  const onDrop = (e: DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setDragging(false);
    handleFiles(e.dataTransfer.files);
  };

  const onChange = (e: ChangeEvent<HTMLInputElement>) => {
    handleFiles(e.target.files);
  };

  const onAnalyze = () => {
    setAnalyzing(true);
    setTimeout(() => {
      setAnalyzing(false);
      navigate({ to: "/skill-gap" });
    }, 2000);
  };

  return (
    <div>
      <div className="mb-8">
        <div className="flex items-center gap-3">
          <Sparkles className="h-8 w-8 text-primary" />
          <h1 className="text-3xl font-bold text-foreground">
            Resume Intelligence
          </h1>
        </div>
        <p className="mt-2 text-sm text-muted-foreground">
          Upload your resume to extract skills, experience, and get personalized
          job recommendations
        </p>
      </div>

      <div
        onDragOver={(e) => {
          e.preventDefault();
          setDragging(true);
        }}
        onDragLeave={() => setDragging(false)}
        onDrop={onDrop}
        className={`rounded-2xl border-2 border-dashed bg-card p-[60px] text-center transition-all ${
          dragging
            ? "border-primary shadow-[0_0_40px_rgba(0,212,255,0.45)]"
            : "border-primary/70 shadow-[0_0_20px_rgba(0,212,255,0.15)]"
        }`}
      >
        <input
          ref={inputRef}
          type="file"
          accept={ACCEPT}
          className="hidden"
          onChange={onChange}
        />

        <button
          type="button"
          onClick={() => inputRef.current?.click()}
          className="mx-auto mb-6 flex h-20 w-20 items-center justify-center rounded-full bg-primary text-primary-foreground shadow-[0_0_30px_rgba(0,212,255,0.4)] transition-transform hover:scale-105"
          aria-label="Upload resume"
        >
          <Upload className="h-8 w-8" />
        </button>

        <h2 className="text-2xl font-bold text-foreground">Drop Resume Here</h2>
        <p className="mt-2 text-sm text-muted-foreground">
          Support for PDF, DOC, DOCX files up to 10MB
        </p>

        <div className="mx-auto my-6 flex max-w-sm items-center gap-4">
          <div className="h-px flex-1 bg-border" />
          <span className="text-xs font-semibold tracking-wider text-muted-foreground">
            OR
          </span>
          <div className="h-px flex-1 bg-border" />
        </div>

        <button
          type="button"
          onClick={() => inputRef.current?.click()}
          className="inline-flex items-center gap-2 rounded-md bg-primary px-5 py-2.5 text-sm font-semibold text-primary-foreground transition-colors hover:bg-primary/90"
        >
          <FileIcon className="h-4 w-4" />
          Browse Files
        </button>

        {file && (
          <div className="mt-6 inline-flex items-center gap-3 rounded-lg border border-border bg-background/60 px-4 py-2 text-sm">
            <FileIcon className="h-4 w-4 text-primary" />
            <span className="font-medium text-foreground">{file.name}</span>
            <span className="text-muted-foreground">
              ({formatSize(file.size)})
            </span>
          </div>
        )}

        {error && (
          <p className="mt-4 text-sm text-destructive">{error}</p>
        )}
      </div>

      {file && (
        <div className="mt-6 flex justify-center">
          {analyzing ? (
            <div className="flex items-center gap-3 text-primary">
              <Loader2 className="h-5 w-5 animate-spin" />
              <span className="text-sm font-medium">
                Analyzing your resume...
              </span>
            </div>
          ) : (
            <button
              type="button"
              onClick={onAnalyze}
              className="inline-flex items-center gap-2 rounded-md bg-primary px-6 py-3 text-sm font-semibold text-primary-foreground transition-colors hover:bg-primary/90"
            >
              <Sparkles className="h-4 w-4" />
              Analyze Skills
            </button>
          )}
        </div>
      )}
    </div>
  );
}