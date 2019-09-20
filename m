Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F906B8BB0
	for <lists+linux-mmc@lfdr.de>; Fri, 20 Sep 2019 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393049AbfITHm6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 20 Sep 2019 03:42:58 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34353 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393040AbfITHm6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Sep 2019 03:42:58 -0400
Received: by mail-vk1-f196.google.com with SMTP id d126so1392700vkb.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2019 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Og92PK7lYuYxZVroo0I3fiUsRwDg032RIvVPfcZDz9g=;
        b=pytRpzDQlDd43MinOxKbi8uqIvJ3ntOh9vfhvnAVt87Jq56QaUx03Fg5JnldbvdAAY
         0NTWM4iprCKUJyuzGw35eX863u9+ZtC02/IkTZCLFO5DI2qFnELZ2HlwpWh3suuk1Xwc
         SxTr5+VtHrUc62XyPyA9S1FL5g3WzGTDYNKZK0wf3r2vKfKeCaLl7sFj8nkjdaNcXPN4
         x4VLVZ2C/hBlkviyHixSyljJmUILQ1CC+Vn1lW1qYycdWUoF9fBid2e117FrqIQNjm/n
         ZMBTgF3taIj2iuyx1eBLNHoX9WtgiU8FAtr6YxwvfrrRFNDVSqKz9QySnFuLX//HLhwS
         dg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Og92PK7lYuYxZVroo0I3fiUsRwDg032RIvVPfcZDz9g=;
        b=HaexkN5WqHMoj3kS7EsMLgL8VqJTDwEgOybHyru0WQTMvF8dEFUbS//xmW2x8OVFcU
         KZbeJx1YDS1z4XuX/35F/uN7MS+0jHerYtO8sGC+yW7ll0s2v0sBCx8VrFNZHTqv8dvR
         Rgx2mDo9vchlgOO/Gm13022tZOYi4j+szYABzyT4QUbIf+jv3/pr8oMvRWv5L5pg0n9C
         +i71gRLSX7umukEsD4s9mF6cy5EGDRA2kGGxpBjuKcWR6r6v6VBWhG4W5yJ8D4qfZWvf
         eYIoxpdNWIeOEUBK6diLNcoZeJb/pBLzS7+ONQjflOzZGt/onceT8trHm4MPe/P/Tohz
         EF/w==
X-Gm-Message-State: APjAAAWpxtk+PHZ4hF4lq0kuIITP5VxwrhU8ixaW2KTcLhKgeS+64qKR
        iwXMPvTBkFyxcEdp4mxP9i6Bj09zvp0L5hrY7YwpNw==
X-Google-Smtp-Source: APXvYqzeAbPjybDZ+vBRhEdO6biNo/RravmZvb9w7AWjx86v7n7nmiui7V5NcVtaybCFi9rV9GIoxy35TYNC25gIh6g=
X-Received: by 2002:a1f:da45:: with SMTP id r66mr3600161vkg.36.1568965377565;
 Fri, 20 Sep 2019 00:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190916204158.6889-1-efremov@linux.com> <20190916204158.6889-24-efremov@linux.com>
In-Reply-To: <20190916204158.6889-24-efremov@linux.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Sep 2019 09:42:20 +0200
Message-ID: <CAPDyKFoVEMex2_p1M-cFZnGLuwgK0wZk-kL_eZ=eDiT1tjvDGA@mail.gmail.com>
Subject: Re: [PATCH v3 23/26] memstick: use PCI_STD_NUM_BARS
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Sep 2019 at 22:47, Denis Efremov <efremov@linux.com> wrote:
>
> Use define PCI_STD_NUM_BARS instead of PCI_ROM_RESOURCE for the number of
> PCI BARs.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Assuming this depends on other changes in the series? Thus this is
probably for PCI maintainers to pick up?

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index 32747425297d..fd281c1d39b1 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -848,7 +848,7 @@ static int jmb38x_ms_count_slots(struct pci_dev *pdev)
>  {
>         int cnt, rc = 0;
>
> -       for (cnt = 0; cnt < PCI_ROM_RESOURCE; ++cnt) {
> +       for (cnt = 0; cnt < PCI_STD_NUM_BARS; ++cnt) {
>                 if (!(IORESOURCE_MEM & pci_resource_flags(pdev, cnt)))
>                         break;
>
> --
> 2.21.0
>
