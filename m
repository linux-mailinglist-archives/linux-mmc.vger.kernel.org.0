Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBF427DF
	for <lists+linux-mmc@lfdr.de>; Wed, 12 Jun 2019 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFLNn1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 12 Jun 2019 09:43:27 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43395 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfFLNn1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jun 2019 09:43:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id d128so10256751vsc.10
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jun 2019 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOmrgQcD/lSti5Qh71Stv0ataNYNESHJ6g2zB80MgJE=;
        b=RMNltOgIPJ7TW0YTQcEvULo3TkaGMhgixILLxsUTZMlg9hB7LkUbXLV2fswn8bp9iV
         /qsCdg7+H/mCTIMBUjdCMjunQzyV8BGnZCjx5jXwTL2w0tYWSQaX85mGSJDjlc8ZrTjc
         QM06q/bkY+nEXMCaas2Ic6iWzjUBkwVwaMLnV8vfeIr9zynmLRpV+9Lgh1qcRIWtADev
         8arL8t1ohG7hYAd8GbnrQDiryPih9sBqegBBCvrUkwJvzvY4IytC+5U1B2LOUphZ4VcO
         OpOydkAWoY1hBCkqcxl4NB38GWn4Q0SkBTH+5oBjCkQq07dXtAdlIXRg4oUJKdY1V8dV
         z64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOmrgQcD/lSti5Qh71Stv0ataNYNESHJ6g2zB80MgJE=;
        b=AGxQn+9jlMR4YfLdVaCVFQya0VVwTUN2saCApYz37UYdat2QyvmjJSL6EwkhzclhZZ
         8DfxDVD4MutkYxuRDqWJKzNoucXCC/1DB6T385uyA+Viab1Tp4AK5Ylk2MrD5VWh01CA
         qh9sicIayg8T/39VVQ84Ko5bP3hPVqQO0+OHpyTNzky31BktT2YuAtKRw85r5IwdtIeE
         UXEQMYV6mIpQhnJlN/ZpLiYMI90Kzl0OSTMnbkUOqJz9R/O8gqc/b00uY589RFA8BSgO
         SBG9ML82SEQHLenJ4leUozwU684y0UGCpEwVHm2jSdFeTx8Jhtr+berjZPZrEW65rlsD
         Z4Kw==
X-Gm-Message-State: APjAAAVxSlCDrqiEQNircw2vySWUZUMHES4CSIG8ylfSYbjBA60JCwWL
        nsDC1EkJRyV2GbKGtoFe2aDGQs9Bm3K+xwaFSSO5ow==
X-Google-Smtp-Source: APXvYqzBzSRapUWvVQUQ4WKVQvhfEDjlTToobgTaZsocNytd3GbbujFaPYU62UQMMnPDC9VWRraClJHmnwqtNxHu5rA=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr10810132vsp.165.1560347006610;
 Wed, 12 Jun 2019 06:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190610185354.35310-1-rrangel@chromium.org> <20190610185354.35310-3-rrangel@chromium.org>
In-Reply-To: <20190610185354.35310-3-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jun 2019 15:42:50 +0200
Message-ID: <CAPDyKFo9U7ChoEQC1QFaW9cXLYQ-Q2UrYyH0KqJd_reyka3zvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Jun 2019 at 20:55, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The value is referring to SDHCI_HOST_CONTROL, not SDHCI_CTRL_DMA_MASK.

Perhaps re-phrase this changelog as to mention that you are removing a
white-space to fix alignment, as that was not so obvious.

Kind regards
Uffe

>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
>
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 199712e7adbb3..89fd96596a1f7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -89,7 +89,7 @@
>  #define   SDHCI_CTRL_ADMA32    0x10
>  #define   SDHCI_CTRL_ADMA64    0x18
>  #define   SDHCI_CTRL_ADMA3     0x18
> -#define   SDHCI_CTRL_8BITBUS   0x20
> +#define  SDHCI_CTRL_8BITBUS    0x20
>  #define  SDHCI_CTRL_CDTEST_INS 0x40
>  #define  SDHCI_CTRL_CDTEST_EN  0x80
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
