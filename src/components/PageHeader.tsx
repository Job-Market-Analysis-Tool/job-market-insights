interface Props {
  title: string;
  subtitle?: string;
}

export function PageHeader({ title, subtitle }: Props) {
  return (
    <div className="mb-8">
      <h1 className="text-2xl font-bold text-foreground">{title}</h1>
      {subtitle && (
        <p className="mt-1 text-sm text-muted-foreground">{subtitle}</p>
      )}
    </div>
  );
}
