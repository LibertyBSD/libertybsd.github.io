import { join, normalize, sep } from "path";

const PORT = Number(Bun.env.PORT ?? "3000");
const PUBLIC_DIR = normalize(process.cwd());

const MIME_TYPES: Record<string, string> = {
  html: "text/html; charset=utf-8",
  css: "text/css; charset=utf-8",
  js: "application/javascript; charset=utf-8",
  json: "application/json; charset=utf-8",
  png: "image/png",
  jpg: "image/jpeg",
  jpeg: "image/jpeg",
  svg: "image/svg+xml",
  ico: "image/x-icon",
  txt: "text/plain; charset=utf-8",
};

function isPathSafe(filePath: string): boolean {
  return filePath === PUBLIC_DIR || filePath.startsWith(`${PUBLIC_DIR}${sep}`);
}

function sanitizePath(pathname: string): string | null {
  const normalized = normalize(pathname).replace(/\\/g, "/").replace(/^\/+/, "");
  if (
    normalized === ".." ||
    normalized.startsWith("../") ||
    normalized.split("/").includes("..")
  ) {
    return null;
  }
  return normalized;
}

function resolveCandidates(pathname: string): string[] {
  const requested = pathname === "/" ? "/index.html" : pathname;
  const sanitized = sanitizePath(requested);
  if (!sanitized) {
    return [];
  }

  if (requested.endsWith("/")) {
    return [join(sanitized, "index.html")];
  }

  const hasExtension = /\.[^./]+$/.test(sanitized);
  if (hasExtension) {
    return [sanitized];
  }

  return [`${sanitized}.html`, join(sanitized, "index.html")];
}

async function tryResolveFile(pathname: string): Promise<string | null> {
  for (const candidate of resolveCandidates(pathname)) {
    const filePath = normalize(join(PUBLIC_DIR, candidate));
    if (!isPathSafe(filePath)) {
      continue;
    }

    const file = Bun.file(filePath);
    if (await file.exists()) {
      return filePath;
    }
  }

  return null;
}

const server = Bun.serve({
  port: PORT,
  async fetch(req) {
    const url = new URL(req.url);

    let pathname: string;
    try {
      pathname = decodeURIComponent(url.pathname);
    } catch {
      return new Response("Bad Request", { status: 400 });
    }

    const filePath = await tryResolveFile(pathname);
    if (!filePath) {
      console.error(`[404] ${url.pathname}`);
      return new Response("Not Found", { status: 404 });
    }

    const extension = filePath.split(".").pop()?.toLowerCase() ?? "";
    const contentType = MIME_TYPES[extension] ?? "application/octet-stream";

    console.log(`[200] ${url.pathname} -> ${filePath}`);
    return new Response(Bun.file(filePath), {
      headers: {
        "Content-Type": contentType,
      },
    });
  },
  error(error) {
    return new Response(`<pre>${error}\n${error.stack}</pre>`, {
      headers: {
        "Content-Type": "text/html; charset=utf-8",
      },
      status: 500,
    });
  },
});

console.log(`Static server running at http://localhost:${server.port}`);
