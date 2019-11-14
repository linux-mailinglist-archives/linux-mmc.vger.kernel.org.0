Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FE1FC69F
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNMyI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 07:54:08 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34650 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfKNMyI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 07:54:08 -0500
Received: by mail-ua1-f67.google.com with SMTP id s25so1824328uap.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 04:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TabhCeemnbt5YWJd9CPxReqJBi1D8pdx95Mgt8aSEw=;
        b=CB5Yu2xuaym93+UTMULc25a86wS48QqpxftBXsTLQdXzTUA0toqFuXQyvSaBG1ePNW
         BoPd/uQG44ly2FV0t2Vxpg3zksylWpO/0dVJyu46UIvYM9aOoyzbocACIM1QxzaNDsj6
         eDkqhqLy6my9dbZRpzQieGFrFS4vkno4wSRePgCV7+QoDzx+TC8J0sDIipQUz6Avo2zq
         XvA/wZ5ALcek7yD+OMsBbr/0EEEjOaP8vGkeq6dz9TrRxu8kVzcuzPN7pKLSWCG6LvSV
         ktnYHh0pbFCizUl7ZUEV5JSGOJzbCB+Ru1WZ8Fe4ZWNsjLMJLhsB1rIoGBKvokNKP0bU
         ++NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TabhCeemnbt5YWJd9CPxReqJBi1D8pdx95Mgt8aSEw=;
        b=L5bkRVSGtwtI53OewPnyuK7ZPOWjGV+wtVRlM5KmRDAMHjSCIPVRJFPBlf+8qtF3Hw
         Wo9k5jyfMeHe4vgJLJUt8PMQd3S2lAvX+SJ/tyRpBsP3AeNR8awz3od3q1yqSUtlh/8U
         zim+eNIMrNwGqctaRJfezEss825+yZ07htlH1Ro8PLJHf5Gnf68ap8UHpdJgrEK50CWh
         2e9Yokb9N63Z7SgYv24QOPt1floqap88I8OH1kgeIlLI46kBxHNGXIdvyjLKanX2Upoj
         I13S2XrwgqkSGPQi1ybAaYTX9PZAwkSGQwTpQTgSFZZuOfEkLn86/FrB4u9YeYwN+Ipq
         qvEg==
X-Gm-Message-State: APjAAAVry7nt9tspwgQYcd0IyjpoxCuyRaMN12FDVSBS2IBSGQSKXrna
        yuaUJYUZkzndsJsIkXAEV/+xHYXgbv7pifhj+LfZwg==
X-Google-Smtp-Source: APXvYqwA+J0UCOgnwqppP3NKFyifvH6MtwSxKN//hr4/ukqNE2SPBmLZyMZVnkJC9I1HKis7De+7tL7O3dYz+TSI3W4=
X-Received: by 2002:ab0:3399:: with SMTP id y25mr5316646uap.100.1573736046067;
 Thu, 14 Nov 2019 04:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 13:53:30 +0100
Message-ID: <CAPDyKFp15ZMq1f_xwrPSRbhU4M4SXhRzigA9-QMNBGSZj-YtJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mms: Use dma_request_chan() directly for channel request
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        vkoul@kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 10:35, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi,
>
> I'm going through the tree to remove dma_request_slave_channel_reason() as it
> is just:
> #define dma_request_slave_channel_reason(dev, name) \
>         dma_request_chan(dev, name)
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   mmc: atmel-mci: Use dma_request_chan() directly for channel request
>   mmc: moxart: Use dma_request_chan() directly for channel request
>
>  drivers/mmc/host/atmel-mci.c  | 3 +--
>  drivers/mmc/host/moxart-mmc.c | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
