Return-Path: <linux-mmc+bounces-966-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEB84CFBE
	for <lists+linux-mmc@lfdr.de>; Wed,  7 Feb 2024 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6D51F25833
	for <lists+linux-mmc@lfdr.de>; Wed,  7 Feb 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A5823DC;
	Wed,  7 Feb 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT0o7Pcm"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1981ACA
	for <linux-mmc@vger.kernel.org>; Wed,  7 Feb 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326742; cv=none; b=t8u2bwo46dhCzzntwUnslKpgZGduYz/r3jpPU+PmTxqKyzpH846vV3JuV/5KEbDUO/T3sR/1tgzzInlJgkiYauxZsbd4k84mAeyUgY8jcgHwjv3Fvb6h0B+PUrbdSes4k4qU4QDirP+U3gfF6MGziIboS8s1Cd5ZSwqtGYjrzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326742; c=relaxed/simple;
	bh=BXebPHotLM8qKwCQMvIN7v+edJrZgKOrhmuTMg/ZIew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPdwuLzJU8aEJIhlfGLtrIds4GLKjuq5ezs1bAdqaeMAAlZPg4ILI8gv/vWvm8w54han0j7CroogMmOh3asUClGMzwAbcznGIzLA3/0iP7YqZnOxIuL/P4tRFHCxht7clq/QKWEIQ5Ip/n5i+SQ+jiSKwKehfi5TumAmNAWDLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pT0o7Pcm; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6049b115630so310727b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 07 Feb 2024 09:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707326740; x=1707931540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9GbhGJFen+rZb/8GL5jjUcVb+EgOwgfWs6I0/DZPcxw=;
        b=pT0o7PcmiEDqRffzmzjIB7PwAfYwJNQcmdAefCNQPIFuawcGE+kAE0BsEmhj82v9tH
         iFif3BCEriIKITdmaLyxRdhxUOsJn/MD5lih5pdX7kx6UlZpPJYMXUsqjuxg8Ao2EZZL
         ltQC+Cs1hRrYvbu/yJG9Bed9Uem9oOMHZUKyu9cTxLnL9pgISZ+Eq1h0Ox6M6YqrcuDx
         rPAl8sB5h79UDVq84MMoWjA5CRPtCQiLzx/ASy0BzLY563yvWDIDlYl0qIONktQSZkQp
         2iRAs4pOZyKsRzlUG7aN/JqWQVSGeN15eaOJ1GM35N0zM2q8+5qRL+vnxd1Hjg2PBFSK
         HrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326740; x=1707931540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GbhGJFen+rZb/8GL5jjUcVb+EgOwgfWs6I0/DZPcxw=;
        b=EmJ1Nvdjtu9WHQ0kyf24cejjMqKXgiKrX5WjDgbxjq31iKOgNmSKDFZoZFwiSOY/Fj
         dO8N5HDG5f/+Yx2XxMRGCh1Z698acW2si1UWRxHUg4VThkSOpK+vJX9VYAh/6dchoPou
         aEvk2nzMIFy+dti45F1aybz3oPhJAlMtjCnJlonN8Ziz1/aUZszP91hr7aVHPAg01mod
         nidBalyzG3bBn2fqv6AiFyzHnP0c1ThbwM+3uEkGTleEt8qT5dGyXb4VxTIbDlhC3nEb
         Ym9rMqv3gyX3773kjVwL9o0ma6buEBgaIUx7FQA0r+FXkVlQsaMIDbrW6/7xZbXJR+Xv
         8kfw==
X-Gm-Message-State: AOJu0YxfZBpnWsNqcudkOLUE7WGUGcjHRLOedNvZB8kx6kZKhGv98GFU
	+w+YlfzKHlthOBBlClWyJoQ6AKCvG7EFK4VB1SrQotlvopa0oShrQb0R3BEKKg1VsQ/cpcLfbqg
	JRwyp39+dF91F9nu/HUHDkdwqQ7wd5v40m10zyw==
X-Google-Smtp-Source: AGHT+IGQO/9l5ukVJW+rU324VKLli8+rokC4rjP97uL2WFBDb8tWzKiYyHSlJsLEiqNchTk6Baf3AaGxtZGdeJ93mLE=
X-Received: by 2002:a0d:e813:0:b0:604:9ce9:5132 with SMTP id
 r19-20020a0de813000000b006049ce95132mr119472ywe.7.1707326739690; Wed, 07 Feb
 2024 09:25:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207170425.478558-1-enachman@marvell.com> <20240207170425.478558-3-enachman@marvell.com>
In-Reply-To: <20240207170425.478558-3-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 Feb 2024 18:25:03 +0100
Message-ID: <CAPDyKFrkCgVeMUy-2UfPNqCDWzZK6AS1EK4MJeOBiHuBxH1k0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: xenon: add timeout for PHY init complete
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 18:04, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> AC5X spec says PHY init complete bit must be polled until zero.
> We see cases in which timeout can take longer than the standard
> calculation on AC5X, which is expected following the spec comment above.
> According to the spec, we must wait as long as it takes for that bit to
> toggle on AC5X.
> Cap that with 100 delay loops so we won't get stuck forever.
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 31 ++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 4e99197b62c3..f551a9e31772 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -109,6 +109,8 @@
>  #define XENON_EMMC_PHY_LOGIC_TIMING_ADJUST     (XENON_EMMC_PHY_REG_BASE + 0x18)
>  #define XENON_LOGIC_TIMING_VALUE               0x00AA8977
>
> +#define XENON_MAX_PHY_TIMEOUT_LOOPS            100
> +
>  /*
>   * List offset of PHY registers and some special register values
>   * in eMMC PHY 5.0 or eMMC PHY 5.1
> @@ -244,7 +246,7 @@ static int xenon_check_stability_internal_clk(struct sdhci_host *host)
>   */
>  static int xenon_emmc_phy_init(struct sdhci_host *host)
>  {
> -       u32 reg;
> +       u32 reg, retry;
>         u32 wait, clock;
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> @@ -282,14 +284,31 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
>         /* get the wait time */
>         wait /= clock;
>         wait++;
> -       /* wait for host eMMC PHY init completes */
> -       udelay(wait);
>
> -       reg = sdhci_readl(host, phy_regs->timing_adj);
> -       reg &= XENON_PHY_INITIALIZAION;
> +       /*
> +        * AC5X spec says bit must be polled until zero.
> +        * We see cases in which timeout can take longer
> +        * than the standard calculation on AC5X, which is
> +        * expected following the spec comment above.
> +        * According to the spec, we must wait as long as
> +        * it takes for that bit to toggle on AC5X.
> +        * Cap that with 100 delay loops so we won't get
> +        * stuck here forever:
> +        */
> +
> +       retry = XENON_MAX_PHY_TIMEOUT_LOOPS;
> +
> +       do {
> +               /* wait for host eMMC PHY init completes */
> +               udelay(wait);
> +
> +               reg = sdhci_readl(host, phy_regs->timing_adj);
> +               reg &= XENON_PHY_INITIALIZAION;
> +       } while (reg && retry--);
> +
>         if (reg) {
>                 dev_err(mmc_dev(host->mmc), "eMMC PHY init cannot complete after %d us\n",
> -                       wait);
> +                       wait * XENON_MAX_PHY_TIMEOUT_LOOPS);
>                 return -ETIMEDOUT;
>         }

Similar comment as for patch1, please convert to readx_poll_timeout()
or similar.

Kind regards
Uffe

