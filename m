Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1567C824
	for <lists+linux-mmc@lfdr.de>; Wed, 31 Jul 2019 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfGaQGJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 31 Jul 2019 12:06:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40362 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGaQGJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Jul 2019 12:06:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so32263592pgj.7
        for <linux-mmc@vger.kernel.org>; Wed, 31 Jul 2019 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dw5dQKwX8ASG6Ts6LgBuSFToiWxM+evOZX45eitYT60=;
        b=nXhNdnpzQ5klubCtfPKL3rrjBDdkcECAJhbzNalPGdQFtuHxtHL5KFS8kYJxX01zI+
         3GqX/EXvBnWwabWBFeHJWv8ENvMiwnd744dcdIMl23dIdrN9eqdKH3FEaOzYWG/FLHW+
         snA2P3tt9xmBEcE0wzL9JO6YiPQXK/ecFHfTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dw5dQKwX8ASG6Ts6LgBuSFToiWxM+evOZX45eitYT60=;
        b=hu3SQFmYQXoJdnvrMpBme3SAOsVBTWDuB8pUSzMO/Rpp8s712pvPs9mIt22HKvvAJw
         UMlt8DJ6iK3R3oNy4ZfXYgfMowNoodI96Un+6OlIa9esQKPPOINlrlIIjTSExPAYzMy+
         AWPVm8Izt3Moby2AxXveOWJ7gzEu64slKO59yTY/A+A8mSDAwXsJ6VdG1FfbuGei3fze
         9tL5O+bQhbvt5zTwLQZdpiM4XWzKAhNKCvLzNrrqK7wNk7oqCV4aFD6NZSmLr9qs0P0x
         mQZJ1larCYAWp8ICTZFFiGKtKVNQtpRpeDy0vJh85tZpzNTryrLeI8vAg0+piR22cpQk
         v8+Q==
X-Gm-Message-State: APjAAAXGzP1bmXmsfitjw7y+gZg6MWrinqWIYmTZwbVNc2JQqbl+WWAi
        C7P3TdXX+7S67469//erENJw4nBHIq4=
X-Google-Smtp-Source: APXvYqyp+rY/4Em+/ZUkiOjo98nR6upEwWWg4wXYmcr0OQ9k/QFwbGOVWkGPKkn54UdzEr838uzIjQ==
X-Received: by 2002:a63:ff03:: with SMTP id k3mr19399349pgi.40.1564589168950;
        Wed, 31 Jul 2019 09:06:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15sm98920836pfn.150.2019.07.31.09.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 09:06:08 -0700 (PDT)
Date:   Wed, 31 Jul 2019 09:06:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Message-ID: <201907310905.B90C6E25@keescook>
References: <20190729000123.GA23902@embeddedor>
 <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 31, 2019 at 01:32:16PM +0200, Ludovic Desroches wrote:
> > drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    host->caps.need_notbusy_for_read_ops = 1;
> >    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> > drivers/mmc/host/atmel-mci.c:2427:2: note: here
> >   case 0x100:
> >   ^~~~
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I don't know if there is a policy in the kernel about the expression to
> use. As this one does the job

Yup, documented here:
https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-switch-case-fall-through

> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks!

-- 
Kees Cook
