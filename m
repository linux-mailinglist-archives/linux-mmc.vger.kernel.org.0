Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D8A31C2
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Aug 2019 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfH3ICF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Aug 2019 04:02:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33634 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfH3ICF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2019 04:02:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id m18so4239054vsr.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Aug 2019 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSReTBR+21k+gQlfPIxdDjT6LtoW1ARQm0j/COjHJ9U=;
        b=qp8yU+LPUcX/mAFN/tdWTbxE8ZDUp2Z8cCy/SKuHHj80GZtnQ3tQP7JQDmbyIBAWoy
         ZePqJezkftPXgjaRJ7H2pFtF5ZnZOQZy4N5kyyN4o2HhEhsa410M5iWSyc0l/Ynzaktm
         YOSy3tWjasqTapLStwH3UrO5al31vEt96KXMWgXhv2YXTynO/2BcGjuL+2uj+TX6vHDJ
         UVwmxzPe4wEYqJUHp6HIsvv7G9ymY37avF2pBFZHYsAo8M6r54t/hRz3V8vqsvpuFx4x
         JuYF9njW9ZhqiqYVZqFshkjVEd+qOApUqzk1gOe47O82ybxuy80NG/F0a3bmeO2YRwQJ
         8eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSReTBR+21k+gQlfPIxdDjT6LtoW1ARQm0j/COjHJ9U=;
        b=pUz4PvqzU2ztFJKmMJJUFDEp4hTf1QcMDP5a61pH3ASrv8jGtNcjWX1/RGhX+4thdZ
         C89sIP/MPiry4gpWWSVuZMyQVhdsNtH3eEfNzDlkPypbFIUMrt8EM6Ltn28gbRhMJrd4
         LAsNMQaYjlG2SgWxYRDpWGnmaHFC0pAR4lgtgn0CU2gU9JUqBNty7qZl5oFE1u+T+Nry
         EWM8TQnhHjgu503sUtGSvgnyXfVDmjUFL16V3gGBgQxgLSQkk5D4yUZ6KaxsjGG4JYya
         WiMj4UZoljzSQq6AxRC2M7lbyv4WVxePNdWzYQEOX4vTJwoF7B7TU09oBT4gX7vlLAML
         NHdw==
X-Gm-Message-State: APjAAAWV9bMLdGl1JKa8rFVuJHlvDeAqB26WWVNwJTZxiTg5KKElD8dc
        obNdWVaDLGIb7412/4X/USDeHbH9TOMTmqLkbV50GQ==
X-Google-Smtp-Source: APXvYqyOx0hFYInMfmpsUnvpCKFGXIHa/+Ahs3V3CNXSh7WcogIeV6A1MSfhHPGxYA3SEvRTgK+RozQPc8r1yR8QgSo=
X-Received: by 2002:a67:983:: with SMTP id 125mr2338906vsj.191.1567152124259;
 Fri, 30 Aug 2019 01:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190830074644.10936-1-andrew@aj.id.au> <20190830074644.10936-2-andrew@aj.id.au>
In-Reply-To: <20190830074644.10936-2-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 10:01:27 +0200
Message-ID: <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-aspeed: Uphold clocks-on post-condition
 of set_clock()
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        openbmc@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Aug 2019 at 09:46, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The early-exit didn't seem to matter on the AST2500, but on the AST2600
> the SD clock genuinely may not be running on entry to
> aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
> sdhci_enable_clk().
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d5acb5afc50f..a9175ca85696 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         int div;
>         u16 clk;
>
> -       if (clock == host->clock)
> -               return;
> -
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
>         if (clock == 0)
> --
> 2.20.1
>

Further down in aspeed_sdhci_set_clock() you should probably also
remove the assignment of host->clock = clock, as that is already
managed by sdhci_set_ios().

Kind regards
Uffe
