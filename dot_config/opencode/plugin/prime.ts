import type { Plugin } from "@opencode-ai/plugin"
import type { Part } from "@opencode-ai/sdk"

export const Prime: Plugin = async ({ client, $ }) => {
  const injected = new Set<string>()

  return {
    "chat.message": async (input, output) => {
      if (injected.has(input.sessionID)) return
      injected.add(input.sessionID)

      await client.app.log({
        body: { service: "tool-prime", message: "Priming session with local tooling" },
      })

      let primer: string
      let part: Part

      try {
        primer = await $`tk prime`.text()
      } catch (err) {
        await client.app.log({
          body: {
            service: "tool-prime",
            message: "tk prime failed",
            extra: { error: String(err) },
          },
        })
        return
      }

      if (!primer) return

      part = {
        id: `tool-prime-${Date.now()}`,
        sessionID: input.sessionID,
        messageID: output.message.id,
        type: "text",
        text: primer,
        synthetic: true,
      }

      output.parts.unshift(part)

      try {
        primer = await $`memos prime`.text()
      } catch (err) {
        await client.app.log({
          body: {
            service: "tool-prime",
            message: "memos prime failed",
            extra: { error: String(err) },
          },
        })
        return
      }

      if (!primer) return

      part = {
        id: `tool-prime-${Date.now()}`,
        sessionID: input.sessionID,
        messageID: output.message.id,
        type: "text",
        text: primer,
        synthetic: true,
      }

      output.parts.unshift(part)
    },
  }
}
