Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31735E316
	for <lists+linux-mmc@lfdr.de>; Tue, 13 Apr 2021 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhDMPo6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 13 Apr 2021 11:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhDMPo6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Apr 2021 11:44:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030EC061574
        for <linux-mmc@vger.kernel.org>; Tue, 13 Apr 2021 08:44:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p67so6730385pfp.10
        for <linux-mmc@vger.kernel.org>; Tue, 13 Apr 2021 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=6QXKqh4iAknKzHknyKmDgPNAk4ykgSh5I8O8twOY8Fs=;
        b=CVU8bnrZ5wc44WdnmmXVPvUZGrbnRxM+yux6/m2WfgT+s8QaAkvYSIpjmVzIym7nOL
         03tvzezVjkMvO24uNX75x9Q0Ns1HAl3eGqbTGx4842okIp2mD1Xt6qlJbIyKdKWP7RzZ
         9NOKelHAn9yeHF1eqES81+zJpoKughXJSdVRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=6QXKqh4iAknKzHknyKmDgPNAk4ykgSh5I8O8twOY8Fs=;
        b=HuIbt6WPQc6eEU9mE2WM+12gSqEqSEoNVAwqs3QS7G5ZyI1xurlBnTfYBJIXpj46gW
         8q3alS4Q4rfH62guHZlJpkHjcBII3Ne0HImpc679VHr31WlDn526PBWGPttdJ5xXfgFr
         PU5KooaPcdzkp07pVnrpZz7KV4WTQHOG+EcmwpE92A3KzvCyOcx0TXytitvUdugxhB+Q
         RyTTTlnldbsNx7iyuK5zmEHVHry2fiJ2TwlEu76+OSVdI1JMawqdQcB0R+VFxDJNVhnn
         2ivzB84ntx94XGYz0cDOjSsI3/l8KgEEM+tsZbNK+o/0CP1lBEfTiwP9fdAoz8GO2wHE
         W60Q==
X-Gm-Message-State: AOAM5304QMopI0tB4ZsSTYewdCgaAK94jo7CKPgD3nWVc6nLxaQeXpig
        lw5atHGxYVBblqE1RnMQe/vpBA==
X-Google-Smtp-Source: ABdhPJyvCft98/r91xeCIRrdIaJeN+oMeCuIxDyV4Tphx7ApoWllzUd0eEjOgjvp47r9mg7NazpwiA==
X-Received: by 2002:a62:77c1:0:b029:244:4080:8c7b with SMTP id s184-20020a6277c10000b029024440808c7bmr25247867pfc.69.1618328675697;
        Tue, 13 Apr 2021 08:44:35 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u18sm12874349pfm.4.2021.04.13.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 08:44:35 -0700 (PDT)
Subject: Re: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC v5.0
 cards
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>, tedirks@micron.com
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
References: <20210408175951.22450-1-scott.branden@broadcom.com>
 <CAPDyKFrBMGjCFCwgaJ1D5f+VJSenp369MDP7KS_PY9JaPYA0Hg@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <90d986f4-bf72-64a6-62ce-cddcf6da43a9@broadcom.com>
Date:   Tue, 13 Apr 2021 08:44:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrBMGjCFCwgaJ1D5f+VJSenp369MDP7KS_PY9JaPYA0Hg@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e0a8de05bfdc81f6"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--000000000000e0a8de05bfdc81f6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

+Travis Dirkes,

Could you provide more details on the Micron data error.

On 2021-04-12 12:44 a.m., Ulf Hansson wrote:
> + Bean Huo, Luca Porzio
> 
> On Thu, 8 Apr 2021 at 19:59, Scott Branden <scott.branden@broadcom.com> wrote:
>>
>> From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>>
>> In certain rare combination of operations, Micron eMMC v5.0 cards
>> may experience data errors if internal cache is enabled.
>> This may lead to eMMC related data errors.
>> Introduce a quirk to disable cache on these eMMC cards.
> 
> Can you please elaborate on this, what combinations of operations are
> you referring to - and what kind of data errors?
> 
> I have also looped in some of the Micron guys, to let them chim in.
> 
>>
>> Signed-off-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/core/card.h   | 5 +++++
>>  drivers/mmc/core/mmc.c    | 4 ++--
>>  drivers/mmc/core/quirks.h | 8 ++++++++
>>  include/linux/mmc/card.h  | 1 +
>>  4 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>> index 7bd392d55cfa..22cea63ac359 100644
>> --- a/drivers/mmc/core/card.h
>> +++ b/drivers/mmc/core/card.h
>> @@ -222,4 +222,9 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
>>         return c->quirks & MMC_QUIRK_BROKEN_HPI;
>>  }
>>
>> +static inline int mmc_card_broken_cache(const struct mmc_card *c)
>> +{
>> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE;
>> +}
>> +
>>  #endif
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 8741271d3971..cd83b7f0e59c 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1820,12 +1820,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>          * sudden power failure tests. Let's extend the timeout to a minimum of
>>          * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
>>          */
>> -       if (card->ext_csd.cache_size > 0) {
>> +       if (!mmc_card_broken_cache(card) && card->ext_csd.cache_size > 0) {
>>                 unsigned int timeout_ms = MIN_CACHE_EN_TIMEOUT_MS;
>>
>>                 timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
>>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> -                               EXT_CSD_CACHE_CTRL, 1, timeout_ms);
>> +                                EXT_CSD_CACHE_CTRL, 1, timeout_ms);
>>                 if (err && err != -EBADMSG)
>>                         goto free_card;
>>
>> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
>> index d68e6e513a4f..23972d87c82a 100644
>> --- a/drivers/mmc/core/quirks.h
>> +++ b/drivers/mmc/core/quirks.h
>> @@ -116,6 +116,14 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
>>         MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
>>                               0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
>>
>> +       /*
>> +        * In certain rare combination of operations, Micron eMMC v5.0 cards
>> +        * may experience data errors if internal cache is enabled.
>> +        * Disabling cache for these cards eliminates the issue.
>> +        */
>> +       MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_MICRON,
>> +                             0x014e, add_quirk, MMC_QUIRK_BROKEN_CACHE, 7),
>> +
>>         END_FIXUP
>>  };
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index f9ad35dd6012..22f256a4e54e 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -270,6 +270,7 @@ struct mmc_card {
>>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>> +#define MMC_QUIRK_BROKEN_CACHE (1<<14)         /* Disable broken cache */
>>
>>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>>
>> --
>> 2.17.1
>>


--000000000000e0a8de05bfdc81f6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cRe0CRXA7ypOJSgxO/nOOyQoaJxT7CGg1npOeSpPjEuc3fE4xum3l0nvU85hj6MlKZu43hokdBh0
D0nLyyhEwlR3AC/msdff/UGbM/JR9vk812RP4m/aNWZFJwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOhjEpl04Sz9dh5MI82E1
V39lM/owDQYJKoZIhvcNAQELBQADggEBAA7Rlypx/esz/iq1yA4+KW7uwV/aBY344BWcXt6I+SNK
VwFBgFWfLj5vaEud9TVv2fPSiaHJo0umemOJk+43QD+bsoqmgcFXd21PrOt7Jjs+jjVED9VC5kJq
S4NNKUkS+BqijJwSegtVygrc/atrIlJbjI21q4qpemUo5fgwqCNm++BmBGTI8yA09vtGSNDRN42k
lLX9hl3iEj5SBgkQqCbbnoE+ZjjKfqt7ED166WhgyQWNrl39yLcvLj+JRUB3RuvXKZjH0NQEEBII
wZBDSkyneykLt3CBNIhSCTxKM6OWxVp936ALSa5K9FNy00TeWSpokR6NmzaW8VD/EjTgvqAxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx9oXSJpKniO4dS
Gk8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIF2h0DTytCMkWXA3CrAoruFrD5nc
BTlF1YpLTj8VyTQHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQxMzE1NDQzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQATPCDlzrvzzeb8uxuOPG9+suv2VKMWCHBknHYtE2UZgGzQ
jYe9w8PV9p4fxKcfcluRFR9crRYIqyt6xHpOQz4ZX0xa8tzpazo0QJdwlhsOnv41PPQGGn+BC9dh
yyvPMb+ewryxH/3DsN3aKmKtGf+LBPy+gh3p2eHeKFPLOxdKQ2oXVo17wfJv9pFiHjdbrOKnIHx+
Ry6NJEInuNVbg2z4pjzJGSqzWIhbbB6TZRM96ZglVkZCM1QLuU6/upvEzKPeMYgimH/W8hfRSHwa
B+8pTKHqER4jT4dFR2GlpJKtjxQzgn+EzKoxBCTNiB2KhldFTNTURho9dcBlGXvD8IF6
--000000000000e0a8de05bfdc81f6--
