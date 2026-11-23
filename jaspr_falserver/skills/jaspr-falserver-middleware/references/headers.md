# Security headers

`package: jaspr_falserver`. Server-only: import it only from the server entrypoint and code that only the server entrypoint reaches.

## `securityHeadersMiddleware`

`Middleware securityHeadersMiddleware({String? referrerPolicy = defaultReferrerPolicy, String? permissionsPolicy = defaultPermissionsPolicy, String? contentSecurityPolicy = defaultContentSecurityPolicy})`

Adds `referrer-policy`, `permissions-policy`, and `content-security-policy` to every response, whatever its status or method.

| Header | Default constant | Value |
|---|---|---|
| `Referrer-Policy` | `defaultReferrerPolicy` | `strict-origin-when-cross-origin` |
| `Permissions-Policy` | `defaultPermissionsPolicy` | `camera=(), microphone=(), geolocation=(), payment=(), usb=()` |
| `Content-Security-Policy` | `defaultContentSecurityPolicy` | `frame-ancestors 'self'; base-uri 'self'; object-src 'none'` |

- A header the inner handler already set is kept; the middleware adds only the missing ones.
- Pass a value to replace a default, or `null` to turn that header off.
- A value containing `\r` or `\n` throws `ArgumentError` once, when the middleware is created.

```dart
Middleware strictSecurityHeaders() => securityHeadersMiddleware(
  referrerPolicy: 'no-referrer',
  contentSecurityPolicy:
      "$defaultContentSecurityPolicy; script-src 'self' 'sha256-yourInlineScriptHash'",
);

Middleware headersWithoutCsp() =>
    securityHeadersMiddleware(contentSecurityPolicy: null);
```

## Gotchas

- The default CSP has no `script-src`: a working one needs hashes for your inline scripts and for scripts a CDN such as Cloudflare injects, so the app adds it.
- Add it as the first middleware, so it is the outermost layer. Otherwise a response that `assetMiddleware` or `sitemapMiddleware` answers itself, such as the 404 for a versioned page route, carries no security headers.
- Because a header the page set wins, a page that sets its own `content-security-policy` replaces the whole default policy for that response; the two are not merged.
