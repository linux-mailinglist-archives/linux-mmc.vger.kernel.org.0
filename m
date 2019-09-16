Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5699B4457
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfIPW55 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 16 Sep 2019 18:57:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46756 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387984AbfIPW54 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Sep 2019 18:57:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so1222181lfc.13
        for <linux-mmc@vger.kernel.org>; Mon, 16 Sep 2019 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=laPzJt3OJIMvrVA37EX/dFU7vRHt+cwZVws62wvSA/w=;
        b=znJp3nwhbqMBu2QAKp9RYV3SDs8zPy5m34NCexeUJEAQoLYKVghX2NFQ2jnPfGIU40
         m0AAW+8gNWSBtJKDa77UnZ8Je04DN1fvW9oL4xItbaQXGhJRvk73Yq9doB5D7vjqxEzF
         ePeBLRHPCA0eIzIWaloUSAiJHybpqSrsp2y6sRMVo2xbHspDrz8ML0SMKAxR1f8Z5KNQ
         7JZV9Tr9X+pvJULaVf7lAPwmoJJ0VTkArH0vxrPdVudyqY6uCayF2nGuZO56OMZEFqOu
         e1aGq9wrtO0/xNZ8RiheEcPzTQC86IICadwUtZww0F0M8S0WQx2dWHSzwFsJWb+KQUG6
         2uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=laPzJt3OJIMvrVA37EX/dFU7vRHt+cwZVws62wvSA/w=;
        b=P+HY1hRjJEu470n1BtKr4j3RvqwLQSK4yQhA4eObXzozch2qwPZYQXxq66sruEivVF
         /I3W2DBmCT5GWLlLl0OvLk/0w/9JQLYjTtKpbrFGvIsUhmdMPHZk6nhcGY4P0qjGsbUZ
         YlRdmNQyd4fW7RUcwTBXyoVz5bubCRUhvYA8JgvDCb/FK5NQrSAEbdOYVEPpZbW6ddYc
         GUS4nSxymDYOM8p0+efTH3m3sbaKGCY9rcgd4KkGEk0VZLS3hdgYqIYyhnHGkdD9/QCV
         RntIv8r0Y8DNteKm8F13GNF3p16VfCWByOMUzJIQ1lIE0Ydv4QXz9hrJocI8Nhmvv3hL
         mz6w==
X-Gm-Message-State: APjAAAUIFMqMUSgQY/ZiaW1BJLk/FoBU95CEBNIwOa6qXNGr9fAU2rTF
        VbwjNI/sG7qpo8EwXXh+VbgqHv/pr1s0neQ4YavTWQ==
X-Google-Smtp-Source: APXvYqxGugmI/q00XRABn7wo1+xpinSyI8nPcr9dZ0fY7WFEmhoKKmYDwsalRoHPv3m8HXeSHBXbBXgJYckrJpHoqR4=
X-Received: by 2002:ac2:55ab:: with SMTP id y11mr284333lfg.165.1568674673341;
 Mon, 16 Sep 2019 15:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org> <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190916154546.24982-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Sep 2019 00:57:41 +0200
Message-ID: <CACRpkdZC9t-1ZtFzn=4tyWjVteRog6M=VDb5Y+g_3qSfVO_epg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux-actions@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 16, 2019 at 5:46 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add devicetree YAML binding for Actions Semi Owl SoC's SD/MMC/SDIO
> controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Neat use of yaml!

Yours,
Linus Walleij
