<script>
    import { Select, SelectItem, TextInput } from "carbon-components-svelte";
    import { createEventDispatcher } from "svelte";

    const dispatch = createEventDispatcher();
    export let authData = { type: "none", token: "", username: "", password: "" };

    const authTypes = [
        { id: "none", text: "No Auth" },
        { id: "bearer", text: "Bearer Token" },
        { id: "basic", text: "Basic Auth" }
    ];

    $: {
        dispatch("change", authData);
    }
</script>

<div class="auth-container">
    <div class="auth-type-selector">
        <Select labelText="Auth Type" bind:selected={authData.type} size="sm">
            {#each authTypes as type}
                <SelectItem value={type.id} text={type.text} />
            {/each}
        </Select>
    </div>

    <div class="auth-inputs">
        {#if authData.type === "bearer"}
            <TextInput
                labelText="Token"
                placeholder="Enter Bearer Token"
                bind:value={authData.token}
                size="sm"
            />
            <p class="helper-text">The token will be added to the Authorization header as <code>Bearer &lt;token&gt;</code></p>
        {:else if authData.type === "basic"}
            <TextInput
                labelText="Username"
                placeholder="Username"
                bind:value={authData.username}
                size="sm"
                style="margin-bottom: 10px;"
            />
            <TextInput
                labelText="Password"
                type="password"
                placeholder="Password"
                bind:value={authData.password}
                size="sm"
            />
            <p class="helper-text">Credentials will be Base64 encoded and added to the Authorization header.</p>
        {:else}
            <div class="no-auth-message">
                This request does not use any authorization.
            </div>
        {/if}
    </div>
</div>

<style>
    .auth-container {
        display: flex;
        flex-direction: column;
        gap: 20px;
        padding: 10px;
    }
    .auth-type-selector {
        width: 200px;
    }
    .auth-inputs {
        max-width: 500px;
    }
    .helper-text {
        font-size: 11px;
        color: #6f6f6f;
        margin-top: 5px;
    }
    .no-auth-message {
        color: #6f6f6f;
        font-style: italic;
    }
    :global(.auth-container .bx--text-input),
    :global(.auth-container .bx--select-input) {
        background-color: rgba(0,0,0,0.03) !important;
        border: 1.5px solid transparent !important;
        border-radius: var(--ui-radius-md) !important;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        font-size: 13px !important;
        height: 40px !important;
    }

    :global(.auth-container .bx--text-input:focus),
    :global(.auth-container .bx--select-input:focus) {
        background-color: #fff !important;
        border-color: var(--brand-primary) !important;
        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1) !important;
        outline: none !important;
    }

    :global(.auth-container .bx--label) {
        font-weight: 600 !important;
        color: var(--ui-text-desc) !important;
        margin-bottom: 6px !important;
    }
</style>
