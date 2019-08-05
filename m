Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E75181578
	for <lists+linux-mmc@lfdr.de>; Mon,  5 Aug 2019 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfHEJap (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 5 Aug 2019 05:30:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38581 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHEJap (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2019 05:30:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id h28so57329607lfj.5
        for <linux-mmc@vger.kernel.org>; Mon, 05 Aug 2019 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F9uPCRSmPiTo2hK4r/nBZb2ETnTkjzstupTkcKIfow=;
        b=t7U6r61gh2G+txxmAuRpaIMbfCPRaDMyyIO/DfFxxg+JtNnGBLZnUxPz1OT31MR8Ta
         u+bgHQQrsqGfkRbNhJKzPtenaidsGBnCiThyLb/tzDCpvLiVaH90rNOyUb/jua0ryyG+
         nV4IiAWVB2f+6NLuV/5aG0usZKw/35iQ1ehdXDFboqr9ZKKz1MWi+luLMSLdXOZbFmXl
         8UtI6s3GxdQ+zbEt7opMRSYufzsClWfsWpvLl3KSpb997MD0EBvKNNuqkW3X/eYjtj+Y
         IulB2m4FlF2d7DwCcYEvXhSTTA1xAcZw6ZaYLGTBZtEJLhQRfIwYKHJzat/TMsiluHdf
         AQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F9uPCRSmPiTo2hK4r/nBZb2ETnTkjzstupTkcKIfow=;
        b=eMXBlzZ5+Z+Iafl0ynJR7PopgK2cyJh3hUFw0N67NYI4PPILhJ9cwuzyS6YRtIP8a/
         eJiT6GEy1INCWEKQ6tnIzcJcrdf+UlgcVoDX1EzLfDTTp+KKlatIhww5DbO8TbDd5V3K
         +kRFpPwZGVjnnUOYJRNP78aAuhkgiWwGhaqnvIpLUMzXf5FRthAbra/TKrh0Rl57SYvK
         sd4e0gElBUgk001dEz4NwB8Y3yFn/4qx4MenYQo3u/8vJUxXo2OkUjk+hR6LgRnL0A43
         KkNCQjd2wHj6p8puow4v6e8uBsr/uAFiWIa/q0hJ8rKSePexzARe6+72fSOTZnJIUBUA
         rUrQ==
X-Gm-Message-State: APjAAAVyQQe6YBonFiVM74BfUWWdgEm96Fb608CiM6giKOK/1xmFnIyx
        cPS78L8pTIB8Ad+wrfMLXOHxq9g7bGUMMInTK5Es5A==
X-Google-Smtp-Source: APXvYqz7JBE9oQJCNW1UI+7INxOFq+v6UPMn9y4R/8owWAYGv9h3lldCN/2lgwanhTATZmfTmuSrRDYfei2zMsXMHWs=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr68650031lfh.92.1564997443136;
 Mon, 05 Aug 2019 02:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1563776607-8368-1-git-send-email-wahrenst@gmx.net> <1563776607-8368-2-git-send-email-wahrenst@gmx.net>
In-Reply-To: <1563776607-8368-2-git-send-email-wahrenst@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 11:30:31 +0200
Message-ID: <CACRpkdYN249RE+=MpKz0X6Y9rX=hMQHPQmou6EMdCkO-m2LsDQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] dt-bindings: pinctrl: bcm2835: Add brcm,bcm2711 compatible
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 22, 2019 at 8:23 AM Stefan Wahren <wahrenst@gmx.net> wrote:

> Add a new compatible for the BCM2711.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
(...)
> +  "brcm,bcm2711-gpio" - BCM2711 compatible pinctrl

Completely uncontroversial so patch applied.

Yours,
Linus Walleij
