Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F280EE508
	for <lists+linux-mmc@lfdr.de>; Mon,  4 Nov 2019 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDQqf (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 4 Nov 2019 11:46:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35357 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfKDQqe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2019 11:46:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id l10so17910803wrb.2
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2019 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yYqCq8KhOX1XfK+4my7gRFLEElNBe7VMFAXF/vowPJU=;
        b=zaGsSIhEQJNli0xTl6p2gaxhcRnC0CeRxYnx8/folWOcBW0KnPgmwxUa1sTvuv2+ml
         Tm+gwngevn4bGV3HFC0ftCV2eLmFgsOFhyKilnqEzUpM3cdPjFp5PfrYo7W3Wsyni+U0
         CzMKT53+/ymQi7GUFT2teuz42fm0IhuKz8Z3GHU1pvpLj88tckih7ne1f2CG40kpEbLJ
         6OhXbabxb7DZwroauWzVZwSnMjE1KoSMo16cNF1pzAqmfGg6m9NYvCtuNJeh/U4xRayA
         8wLLxpq+bs4udOGFWbsGZBo8HUsxfOYE2YovROhs13GBbKbIBXCbhkUKRgMQigvTaeBS
         JS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=yYqCq8KhOX1XfK+4my7gRFLEElNBe7VMFAXF/vowPJU=;
        b=MromRuBpvNNwbRW94i43gJM6bgDgfwfL8Aw8aybVhGHJjNYR451dPNmrWK6wih1qlH
         gh/zd+8PpIt/ExhjnzNGh/JiD3ecbHCqMhDvn/3d0SMvofy15XxDTik+NlEoml4hK+HR
         Q9OR8MYsUx/mUdXlTGe0tsvZWToLOuf002cBtr/+z4k9V1clAyxDr9ffB/ATorsNlIho
         L25E+/fGY+azgCPIIumcYzdTyUNX+Y86tO8WjSankM7eJ6i9WIPzFuzrSsZ/p1YNDhIl
         Vlutt5NdEWdmvt3c3PhHQszSXsGlfSacGXGsGibeoU78f7MmSGP1Uu6XDvI8HMI3nbC9
         ookw==
X-Gm-Message-State: APjAAAU61iE9Q13qvrKmIdiKTTOycAZJgxtwgUGqYUxBGJ9vSFjqFk29
        J060skRFm8NBsCcVnbGUsaNa+Q==
X-Google-Smtp-Source: APXvYqwtTkntsyrCVChFM/qW78NBMKri8/Pi6x4pYvlGHeSR9ysRFCfTGUvMr3mLkX6O/kklkRqvpQ==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr24013158wrv.5.1572885991569;
        Mon, 04 Nov 2019 08:46:31 -0800 (PST)
Received: from localhost (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id t5sm6411032wro.76.2019.11.04.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:46:30 -0800 (PST)
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nan Li <nan.li@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
In-reply-to: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Mon, 04 Nov 2019 17:46:29 +0100
Message-ID: <1ja79b4mje.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Mon 04 Nov 2019 at 12:54, Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> From: Nan Li <nan.li@amlogic.com>
>
> In MMC dma transfer, the region requested by dma_map_sg() may be released
> by dma_unmap_sg() before the transfer is completed.
>
> Put the unmap operation in front of mmc_request_done() to avoid this.

In the previous thread, you have described what was the issue you found.
It would be nice to have this information here

>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
> Signed-off-by: Nan Li <nan.li@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Based on Uffe comment I tried something else.

Basically, it enables chained mode in the driver only when the framework
calls pre/post_req callback. As far as understood, the framework calls
this when there is more than one request pending ... which seems to be
when chained mode actually make sense

----8<-----
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e712315c7e8d..399604b4124d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -126,8 +126,7 @@
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
 
-#define SD_EMMC_PRE_REQ_DONE BIT(0)
-#define SD_EMMC_DESC_CHAIN_MODE BIT(1)
+#define SD_EMMC_DESC_CHAIN_MODE BIT(0)
 
 #define MUX_CLK_NUM_PARENTS 2
 
@@ -228,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	struct mmc_data *data = mrq->data;
 	struct scatterlist *sg;
 	int i;
-	bool use_desc_chain_mode = true;
 
 	/*
 	 * When Controller DMA cannot directly access DDR memory, disable
@@ -251,12 +249,11 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 		/* check for 8 byte alignment */
 		if (sg->offset & 7) {
 			WARN_ONCE(1, "unaligned scatterlist buffer\n");
-			use_desc_chain_mode = false;
-			break;
+			return;
 		}
 
-	if (use_desc_chain_mode)
-		data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
+	/* The planets are aligned, let's chain them up */
+	data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
 }
 
 static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
@@ -278,7 +275,6 @@ static void meson_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	meson_mmc_get_transfer_mode(mmc, mrq);
-	data->host_cookie |= SD_EMMC_PRE_REQ_DONE;
 
 	if (!meson_mmc_desc_chain_mode(data))
 		return;
@@ -803,25 +799,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	bool needs_pre_post_req = mrq->data &&
-			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
-
-	if (needs_pre_post_req) {
-		meson_mmc_get_transfer_mode(mmc, mrq);
-		if (!meson_mmc_desc_chain_mode(mrq->data))
-			needs_pre_post_req = false;
-	}
-
-	if (needs_pre_post_req)
-		meson_mmc_pre_req(mmc, mrq);
 
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
 	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
-
-	if (needs_pre_post_req)
-		meson_mmc_post_req(mmc, mrq, 0);
 }
 
 static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
---->8-----

No performance hit AFAICT.
From your description, it should address your problem too.

>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e712315..7667e8a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,7 @@ struct meson_host {
>  	int irq;
>  
>  	bool vqmmc_enabled;
> +	bool needs_pre_post_req;
>  };
>  
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>  	struct meson_host *host = mmc_priv(mmc);
>  
>  	host->cmd = NULL;
> +	if (host->needs_pre_post_req)
> +		meson_mmc_post_req(mmc, mrq, 0);
>  	mmc_request_done(host->mmc, mrq);
>  }
>  
> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> -	bool needs_pre_post_req = mrq->data &&
> +
> +	host->needs_pre_post_req = mrq->data &&
>  			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>  
> -	if (needs_pre_post_req) {
> +	if (host->needs_pre_post_req) {
>  		meson_mmc_get_transfer_mode(mmc, mrq);
>  		if (!meson_mmc_desc_chain_mode(mrq->data))
> -			needs_pre_post_req = false;
> +			host->needs_pre_post_req = false;
>  	}
>  
> -	if (needs_pre_post_req)
> +	if (host->needs_pre_post_req)
>  		meson_mmc_pre_req(mmc, mrq);
>  
>  	/* Stop execution */
>  	writel(0, host->regs + SD_EMMC_START);
>  
>  	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -	if (needs_pre_post_req)
> -		meson_mmc_post_req(mmc, mrq, 0);
>  }
>  
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)

