Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8D9E811
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfH0Mg0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 08:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfH0MgZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 27 Aug 2019 08:36:25 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB31B21883;
        Tue, 27 Aug 2019 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566909384;
        bh=dAxS1WqRV4b7iS74EzUk2CY6pRW9CCrAG7RucQHWt7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j2dZVEnx8ktgPjH/Vaf3xrdEzSnGNtSFvQb0SfS1RJp1Yw9C5pQQz94rLgPcHRpLf
         m7WTkmYD4w13R0zNQJGb0uqtomWErkOaQXu4YeTNlw29sJP3iq4BPmH4EU6v+ms0NV
         w1MKxTKsFpWKD6IwEwRK6gMlCs/hAjpvxJHiQfYY=
Received: by mail-qt1-f172.google.com with SMTP id b11so21036150qtp.10;
        Tue, 27 Aug 2019 05:36:24 -0700 (PDT)
X-Gm-Message-State: APjAAAWL5L431X03ql6VgPxk65BZD7V6tj2kTYCHG6bGNpgy858q4Wwj
        tH7SQcQl1hjYkXH4rXKuV3VAPERYnB/qtcI36g==
X-Google-Smtp-Source: APXvYqyqEKW+TR5bJFFladOyjiCxYJlVjy2VJ+VJSQICBWMQEZulSFTqlCQVzHkPkq4vL9h4hPWYtKn93pLIWauILws=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr22819140qtc.110.1566909383931;
 Tue, 27 Aug 2019 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190826021620.11915-1-andrew@aj.id.au>
In-Reply-To: <20190826021620.11915-1-andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 07:36:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJsLt5FjKayO9ksksrpXDFs3cbAngcQ21xhZYz3JLG=7g@mail.gmail.com>
Message-ID: <CAL_JsqJsLt5FjKayO9ksksrpXDFs3cbAngcQ21xhZYz3JLG=7g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: aspeed: Update example ranges property
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Aug 25, 2019 at 9:15 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The example node in the binding uses the AST2500 compatible string for
> the SD controller with a 64kiB ranges property, but the SD controller is
> allocated 128kiB of MMIO space according to the AST2500 datasheet. Fix
> the example to correctly reflect the hardware in the AST2500, however it
> should be noted that the MMIO region is reduced to 64kiB in the AST2600
> where a second SD controller block has been introduced into the address
> space.
>
> Also add the IBM copyright header that I left out of the initial patch.
>
> Suggested-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Hi Ulf, this is the follow-up fix as discussed here:
>
> http://patchwork.ozlabs.org/patch/1143090/
>
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
