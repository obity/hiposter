<script>
    import CodeMirror from "svelte-codemirror-editor";
    import { json } from "@codemirror/lang-json";
    import { xml } from "@codemirror/lang-xml";
    import { html } from "@codemirror/lang-html";
    import { javascript } from "@codemirror/lang-javascript";

    export let value;
    export let langtype;
    let lang = json();
    $: {
        switch (langtype) {
            case "xml":
                lang = xml();
                break;
            case "html":
                lang = html();
                break;
            case "javascript":
                lang = javascript();
                break;
            case "json":
                lang = json();
                break;
            default:
                lang = json();
                break;
        }
    }
</script>

<div class="code">
    <CodeMirror
        bind:value
        {lang}
        basic
        lineWrapping
        useTab
        editable
        styles={{
            "&": {
                width: "99%",
                height: "100%",
                "font-size": "13px",
            },
        }}
    />
</div>

<style>
    .code {
        position: absolute;
        overflow-y: auto;
        height: 100%;
        width: 100%;
    }
</style>
