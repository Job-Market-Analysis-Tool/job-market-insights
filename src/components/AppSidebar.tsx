import { Link, useRouterState } from "@tanstack/react-router";
import {
  FileText,
  Briefcase,
  BarChart2,
  TrendingUp,
  Settings,
  LogOut,
  Sparkles,
  Map,
} from "lucide-react";

const navItems = [
  { to: "/", label: "Resume Intelligence", icon: FileText },
  { to: "/job-matching", label: "Job Matching", icon: Briefcase },
  { to: "/skill-gap", label: "Skill Gap Analysis", icon: BarChart2 },
  { to: "/roadmap", label: "Career Roadmap", icon: Map },
  { to: "/market-trends", label: "Market Trends", icon: TrendingUp },
  { to: "/settings", label: "Settings", icon: Settings },
] as const;

export function AppSidebar() {
  const pathname = useRouterState({ select: (s) => s.location.pathname });

  return (
    <aside className="fixed inset-y-0 left-0 z-30 flex h-screen w-60 flex-col border-r border-border bg-sidebar-bg">
      {/* Logo */}
      <div className="flex items-center gap-3 px-5 py-6">
        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-primary/15 text-primary">
          <Sparkles className="h-5 w-5" />
        </div>
        <div className="flex flex-col leading-tight">
          <span className="text-sm font-semibold text-foreground">
            Virtual Job Market
          </span>
          <span className="text-[11px] font-medium text-primary">
            Analysis Tool
          </span>
        </div>
      </div>

      {/* User */}
      <div className="mx-4 mb-4 flex items-center gap-3 rounded-lg bg-card/60 px-3 py-3">
        <div className="flex h-9 w-9 items-center justify-center rounded-full bg-primary text-sm font-semibold text-primary-foreground">
          MH
        </div>
        <div className="flex flex-col leading-tight">
          <span className="text-sm font-bold text-foreground">Masab Haroon</span>
          <span className="text-[11px] text-primary">Active User</span>
        </div>
      </div>

      {/* Nav */}
      <nav className="flex-1 space-y-1 px-3">
        {navItems.map(({ to, label, icon: Icon }) => {
          const active = pathname === to;
          return (
            <Link
              key={to}
              to={to}
              className={`flex items-center gap-3 rounded-md px-3 py-2.5 text-sm font-medium transition-colors ${
                active
                  ? "bg-primary text-primary-foreground"
                  : "text-muted-foreground hover:bg-card hover:text-foreground"
              }`}
            >
              <Icon className="h-4 w-4" />
              <span>{label}</span>
            </Link>
          );
        })}
      </nav>

      {/* Logout */}
      <div className="px-3 pb-5 pt-2">
        <button
          type="button"
          className="group flex w-full items-center gap-3 rounded-md px-3 py-2.5 text-sm font-medium text-muted-foreground transition-colors hover:bg-destructive/10 hover:text-destructive"
        >
          <LogOut className="h-4 w-4" />
          <span>Logout</span>
        </button>
      </div>
    </aside>
  );
}
