# Marketing and WhatsApp Workflows

These domains include sensitive write operations. Always load `safety-and-risk.md` first.

## Marketing API Workflow

### Discovery (Read-Only First)

```bash
social marketing status
social marketing accounts --table
social marketing campaigns --status ACTIVE --table
```

### Insights (Read-Only, Low Operational Risk)

Prefer async-ready insights patterns:

```bash
social marketing insights --preset last_7d --level campaign --fields spend,impressions,clicks --table
social marketing insights --preset last_7d --level campaign --fields spend,impressions,clicks --export ./report.csv
```

### Write Actions (High Risk)

Require explicit confirmation with potential spend impact warning:

```bash
social marketing create-campaign --name "Test Camp" --objective OUTCOME_SALES --daily-budget 10000
social marketing set-budget campaign <CAMPAIGN_ID> --daily-budget 15000
social marketing pause campaign <CAMPAIGN_ID>
social marketing resume adset <ADSET_ID>
```

Before create or budget updates:

1. Confirm target account and currency context.
2. Confirm intended daily budget value.
3. Suggest sandbox/test account first.

## WhatsApp Workflow

### Connectivity and Health

```bash
social integrations status waba --profile clientA
social whatsapp phone-numbers list
```

### Message Send Flow (Write)

1. Validate destination and template/body.
2. Confirm send intent.
3. Execute send command.

```bash
social whatsapp send --to +15551234567 --message "Order confirmed"
```

Treat outbound messaging as high-risk when message affects customers or includes promotional content.

## Recommended Confirmation Text

Use this style before any high-impact action:

`This action can change live spend or send customer-facing messages. Confirm to continue.`
