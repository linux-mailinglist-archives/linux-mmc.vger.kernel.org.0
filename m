Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8FA6C98
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Sep 2019 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfICPLU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Sep 2019 11:11:20 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36167 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfICPLU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2019 11:11:20 -0400
Received: by mail-vs1-f65.google.com with SMTP id r1so8729938vsq.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2019 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFtwKcjhJAcLLvYRWcB0GjH8TlxQpGn6eTjYWs9Yv7Y=;
        b=ylEZdt5wX+4ng+59TTe8Z5AM0jrzsN3AaMEYIMADmVTg11r8Zg8hSdomYSWn5vAtNS
         WdPx+HvtbD0mbkYe04TqreDYO2AwhAlo8DcK5wMufHfP3jzW8OLpbSgh9m2ITtJ/93+C
         IuPbGmZNWPRv2XhykPmlWrr3YsWnKOtgf5nZ/c+/4P8yTxomsVGN95qF4sBUOuGdrlSa
         dUqglLFdIaNNuo1end7siNiC4igj3IxjO3ObKeO6Y+PaKLq7Omf2MD0V81QYibQTHBU3
         romyh0SkZgsXqvo8dIMYuUDydOZSEwQ1DoCBYCk4j5XUpRNtrOV9fAzRqNM5npPZQPj9
         JXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFtwKcjhJAcLLvYRWcB0GjH8TlxQpGn6eTjYWs9Yv7Y=;
        b=SeYa/bs4bfWJCA72kJWu+qgU9ijAfXWlD98KgYARoluqe6r9vfsKFMrsjyc3SM9+zb
         Jfmndxwram1JOoPaIUwueCR3bxfvIDXQH2QwN3O0LmoAFWRRBXS0U4xSBRxD3m0YvmgE
         D9tLalg9pr3OGnPnLR1+6yPAeeYs8XPT8tFSOvXagAiFYZFj6+SCwKhErxZVm0uCqkYB
         9HevlEhzUjs1QGkTGQccJjUpL5mMbFh1NEADDrWdevtLVMfTFSzi3m59H2VKJbiKjsoR
         kZqXJsceqTinOyYZZj11MUhdifhOArfE5OWhE258zpibikDhBgzapXgAGiCZwe3wrqg0
         mTfQ==
X-Gm-Message-State: APjAAAWF0Z/TFQiXvcLqsixnCcI3TM5YiQrOjqPn/tBRHHQIH6Rb4GCE
        BtqivZCAUJerPyIz0j8aRLkwptgRKnfu8NkRpnMSwg==
X-Google-Smtp-Source: APXvYqxpIMYeuIve5wcn6H3G3LreaM9TjDByR/E25jlqIh9Wcl9ULuHLdLtj22DL88uDB10bfQJRFWazPxLWyNi4TXU=
X-Received: by 2002:a67:983:: with SMTP id 125mr13702796vsj.191.1567523478905;
 Tue, 03 Sep 2019 08:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190902035842.2747-1-andrew@aj.id.au>
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Sep 2019 17:10:42 +0200
Message-ID: <CAPDyKFph4C7fCcGYzFp2PwwJsaFvw6a0Do4Vm0uF8mbwD7zUzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2 Sep 2019 at 05:58, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> I've added a couple of patches since v1 of this series. The horizon has
> broadened slightly with a fix for SPARC builds as well in patch 1/4. Ulf
> suggested a minor cleanup on v1 with respect to handling of the current clock
> value, so that's now patch 2/4. Patches 3/4 and 4/4 are as they were in v1.

Applied patch 2->4 for next, thanks!

Kind regards
Uffe


>
> The v1 series can be found here:
>
> https://patchwork.ozlabs.org/cover/1155757/
>
> Please review!
>
> Andrew
>
> Andrew Jeffery (4):
>   mmc: sdhci-of-aspeed: Fix link failure for SPARC
>   mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
>   mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
>   mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK
>
>  drivers/mmc/host/sdhci-of-aspeed.c | 62 ++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 20 deletions(-)
>
> --
> 2.20.1
>
