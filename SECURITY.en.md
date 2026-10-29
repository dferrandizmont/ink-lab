# Security notices

If you find a vulnerability, write to **dev@mainshai.com** or open a
[private security advisory](https://github.com/dferrandizmont/ink-lab/security/advisories/new)
on GitHub.

Include the affected version (Settings), the platform, the steps to reproduce the
problem and its possible impact. Send the details through that channel before
opening a public issue, so the problem can be reviewed and a fix prepared. Only
the latest published version receives fixes.

## What counts as a vulnerability

- A way to make the app send data to a destination the user did not turn on.
- A way to read or extract another person's local data, backups or API key.
- A way to execute code through attacker-controlled input, for example a
  tampered backup or the response of an AI provider.
- An insecure local storage of credentials or personal data.

Not in scope: crashes without a security impact, colours that differ from the
manufacturer's website (that is a
[data fix](https://github.com/dferrandizmont/ink-lab/issues/new)), anything that requires
physical access to an unlocked phone, and scanner findings without a
demonstrated impact.

## Do not attach real data

- Do not send your OpenRouter key or any other key, keystore or `.env` file. If
  you pasted one by mistake, revoke it and create a new one.
- Reproduce the problem with test data. If you must send a real backup, first
  remove whatever identifies you.
- In screenshots, cover anything that is not test data.

The same applies to public issues and pull requests.

Spanish version (authoritative): [SECURITY.md](SECURITY.md).
