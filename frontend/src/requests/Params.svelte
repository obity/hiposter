<script>
    import QuerParams from "./Headers.svelte";
    export let params;
</script>

<QuerParams on:click bind:headers={params} />
