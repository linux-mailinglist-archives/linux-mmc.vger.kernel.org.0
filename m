Return-Path: <linux-mmc+bounces-3381-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD19593F8
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2024 07:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB99284C61
	for <lists+linux-mmc@lfdr.de>; Wed, 21 Aug 2024 05:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA45161936;
	Wed, 21 Aug 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="f3VoxKsh"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5D1537D1;
	Wed, 21 Aug 2024 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217492; cv=none; b=QN7sFXXiCTAJUp6qZ5xxwQzCCVvTxoMAsk4oT3voVjNzNlYIe22M86HebnBPxtRishLHyDR+kt2uZNsax3f+A5oj16DlzRVHJCyYCnhGFsW5qQbZo0/Y3vVBtaEXRXknbv9yJcYbhl3SbLaWKfiM3C/2fn4oshszhTXWFh+dnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217492; c=relaxed/simple;
	bh=3BhLGCYcHAMQr1eIKYIjPvz6+438rgIOx7qtF36aFVY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VXAEEf3F9d7zCXR5aaDdYqZuvVMhZU1qGR3LJhXEAS6Ttd0ANLdag46D+2ltB+89fWY0MObJnvRFUST3ia6QhCu0mewQ2u5WyrTENvYsZXjL0k43Jy6DNTFiofsusxShSVSoYGbfrYJgq1q4IlvJq2RDjIa0Wqs9udj6cnzSh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=f3VoxKsh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724217479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW8zne2yRQAoj6MgfEOT7jjL6v4MRR1EpifNpeF9ZCA=;
	b=f3VoxKshAZAq/mCTQLulaYNNqpfnIoh4nxXSQUXpdFjBjKn1LmK6vMDvwj4zTs65XW07OL
	MHkJDoLhqQeutqZLAVRBTYz3K0bUg3b6iTo9T2KSffUrq0hZW2Qtl2gGzf4gQa458iacL6
	4SLxchaTs4EI/rA/Ze/in4QBUJPERVNw1YBR4+h9uYYqPpYi1dzWb4GMEu1Xe7IjdVidKH
	cdjkG+BjTasr01IGXIcwSWui2CLUmW3Ppmvp4LJB4QhefOFmk9dVSMjk66q3yFXhKFaQrk
	F6dSpxIFIqafdK+Cq7A03I4XGD1mCDsH1V3bHEP0PcZ5IDtxgVm7KHHUxofTEw==
Date: Wed, 21 Aug 2024 07:17:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Keita Aihara <keita.aihara@sony.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Bell
 <jonathan@raspberrypi.com>, Tim.Bird@sony.com, Shingo.Takeuchi@sony.com,
 Masaya.Takahashi@sony.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: core: apply SD quirks earlier during probe
In-Reply-To: <20240820230631.GA436523@sony.com>
References: <20240820230631.GA436523@sony.com>
Message-ID: <14df2287d76a66927bd74d4c4dcb5c6d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Keita,

On 2024-08-21 01:06, Keita Aihara wrote:
> From: Jonathan Bell <jonathan@raspberrypi.com>
> 
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks
> are referenced in sd_parse_ext_reg_perf() prior to the quirks being
> initialized in mmc_blk_probe().
> 
> Split this out into a SD-specific list of quirks and apply in
> mmc_sd_init_card() instead.
> 
> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston
> Canvas Go Plus from 11/2019")
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Co-developed-by: Keita Aihara <keita.aihara@sony.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>

Looking good to me.  This fix allows sd_read_ext_regs() to have the
available information for not assigning the SD_EXT_PERF_CACHE as one
of the (un)supported features, which in turn allows mmc_sd_init_card()
to properly skip execution of sd_enable_cache().

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/mmc/core/quirks.h | 22 +++++++++++++---------
>  drivers/mmc/core/sd.c     |  4 ++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..92905fc46436 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,19 @@
> 
>  #include "card.h"
> 
> +static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
> +	/*
> +	 * Kingston Canvas Go! Plus microSD cards never finish SD cache 
> flush.
> +	 * This has so far only been observed on cards from 11/2019, while 
> new
> +	 * cards from 2023/05 do not exhibit this behavior.
> +	 */
> +	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> +		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> +
> +	END_FIXUP
> +};
> +
>  static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>  #define INAND_CMD38_ARG_EXT_CSD  113
>  #define INAND_CMD38_ARG_ERASE    0x00
> @@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused
> mmc_blk_fixups[] = {
>  	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
>  		  MMC_QUIRK_BLK_NO_CMD23),
> 
> -	/*
> -	 * Kingston Canvas Go! Plus microSD cards never finish SD cache 
> flush.
> -	 * This has so far only been observed on cards from 11/2019, while 
> new
> -	 * cards from 2023/05 do not exhibit this behavior.
> -	 */
> -	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> -		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> -		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> -
>  	/*
>  	 * Some SD cards lockup while using CMD23 multiblock transfers.
>  	 */
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..ee37ad14e79e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -26,6 +26,7 @@
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "quirks.h"
>  #include "sd.h"
>  #include "sd_ops.h"
> 
> @@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
>  			goto free_card;
>  	}
> 
> +	/* Apply quirks prior to card setup */
> +	mmc_fixup_device(card, mmc_sd_fixups);
> +
>  	err = mmc_sd_setup_card(host, card, oldcard != NULL);
>  	if (err)
>  		goto free_card;
> --
> 2.43.2

