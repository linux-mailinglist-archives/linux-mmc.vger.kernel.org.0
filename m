Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0274360DCF
	for <lists+linux-mmc@lfdr.de>; Sat,  6 Jul 2019 00:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfGEW3U (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 5 Jul 2019 18:29:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46678 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGEW3U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jul 2019 18:29:20 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so22043710iol.13
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jul 2019 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2xFeB/vxfBJWIi2SCTq+vsVIJL+pCcb0P3THlDfvNk=;
        b=hycMa+7f59LmBeoZx7y+T6iB+NqeRfKUCiEwPvr1G17qNMYTgFWeGgJnfHmpt58y3R
         pE2x4OswYZw80bCfWurEXT3RSUYQLZGIm/hAun3Zsi1gdbn1j5dxcQTLo8sHPU+Ciz7o
         iDfQh6cgbrxML1qV0b61RieVtvOF/c3yjVMQI4kcnTJHkz3r+Xp2keXGFHneyVDSqFe6
         g4Yik34C0kIqHBkyqItwiZt00TrFmr8pZUvduDej+ANXqBVq2TKmE0PkuRWaAIypt0tb
         5n+qAkievhL51pi8/Pk3ZX+Zpn0q4OOrs0azQb3ZvUf+vI+YpFAf4M4GatHRVj+GVVUc
         2Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2xFeB/vxfBJWIi2SCTq+vsVIJL+pCcb0P3THlDfvNk=;
        b=UPO7C3RK7ORNiFnz7X27q+GAwfnca9Hd7L4dYaMpDkWC69sbdWHS1Zqigt1Nxe4gD1
         DEVQWzvBwlzZ/lw6PaEqcJHRcZ5lbMxrynP3NaBleDC+P3QPcepoHN9h9EWOUCAv639W
         KkLCiP3jtfYszqxL25DL5RUBu4Jae9csKiY5S3En6hXUwNdApdTjkxYn/09VCFNzWnDP
         N3KIowR9QISJxAdER9EJ04jNX3rV1GDEpMVnkIVYXEcnZ9bDQS0xttPxIKciqe/VIldx
         X0nZpxBe4Z5+SVwziaQmgoxZ/i6ZSrf3npfwMnqZXX71ptAbDr5frOp03J/YSaijB4eS
         /PxQ==
X-Gm-Message-State: APjAAAXhQcaTpaNkFjaY2/9rumWUNHY+BEvbn+jZHjMvA5mHo9ZVews/
        G+MPERu+4d9fztZiSjNlimOvzerLCdJKybAy72xGuA==
X-Google-Smtp-Source: APXvYqwtqdru004WFVZFoC69PGQmOPnOHdWCXRH4144sBC3NkbqjrE+G/DO1ByoQUCVa7iOf555pJHgtt5vr645kXJM=
X-Received: by 2002:a5d:9642:: with SMTP id d2mr2393845ios.278.1562365759537;
 Fri, 05 Jul 2019 15:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559635435.git.baolin.wang@linaro.org> <15AEA3314E88B01E.21242@linux.kernel.org>
In-Reply-To: <15AEA3314E88B01E.21242@linux.kernel.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 5 Jul 2019 15:29:08 -0700
Message-ID: <CAOesGMjdnQuLdvphBDM3xmH6o+Nca8+65mw8-EajV0Eb_8MS5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mmc: sdhci-sprd: Check the enable clock's return
 value correctly
To:     patchwork-soc+owner@linux.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 5, 2019 at 3:25 PM Olof Johansson via Linux.Kernel.Org
<olof=lixom.net@linux.kernel.org> wrote:

Hmm, well, that didn't work like I expected to. Sorry for the noise.


-Olof
