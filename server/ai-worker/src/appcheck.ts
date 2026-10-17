// Firebase App Check: only accept requests from the genuine app installed
// from Google Play (Play Integrity) or the App Store (App Attest).
// https://firebase.google.com/docs/app-check/custom-resource-backend
import { createRemoteJWKSet, jwtVerify } from "jose";

const JWKS = createRemoteJWKSet(new URL("https://firebaseappcheck.googleapis.com/v1/jwks"));

export type AppCheckVerifier = (token: string | null) => Promise<boolean>;

export function firebaseAppCheckVerifier(projectNumber: string, appIds: string[]): AppCheckVerifier {
  return async (token) => {
    if (!token) return false;
    try {
      const { payload } = await jwtVerify(token, JWKS, {
        algorithms: ["RS256"],
        issuer: `https://firebaseappcheck.googleapis.com/${projectNumber}`,
        audience: `projects/${projectNumber}`,
      });
      return typeof payload.sub === "string" && appIds.includes(payload.sub);
    } catch {
      return false;
    }
  };
}
