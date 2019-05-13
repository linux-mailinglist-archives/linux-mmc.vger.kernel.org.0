Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A41B4E6
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfEML2r (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 07:28:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44928 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfEML2r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 07:28:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so14791099wrs.11
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OnH/4nMvaMi3VQRujj8nm/jF+XYCQszeAWgJCcFUmEo=;
        b=mmoIZ6UXobbUMpQw3nzYycuxwp+5y7k0B4ypB2048OSe2AyCHXff2Fb/oa/E+L2SeM
         9RpramwydA0CLAbKsBuZU1ACHffOCCGYPX9+x/uaVU4wEfND7VI4B4dbctm2/euBTN5c
         8eMa42pnmrEomkuL7hzwW4SzBpWC45nYzA1WHWW9HyDRP8bkvm+iwwlig8edb5Sv6Un8
         V2KaUh/c0yxnZZ3Tj3xrRGZg5ERe5U1wQDH7XcKdVGxwd+kZOdioxMUwGb4N6B+uMEx2
         YaO3Lo+HgXhKdIqXWSH52ksm9Y1Iy/qH58TWAZ06aAQJ36S1B3zMwVdLCHfzEhBTrQuw
         qwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OnH/4nMvaMi3VQRujj8nm/jF+XYCQszeAWgJCcFUmEo=;
        b=tt3071MrusCsZlf/IAWTLQfW29HVBVF8zvn/iZ7jZaC6eMyLhPHENr65dF672CJDEb
         ZlcfD9zkvBnnd0lmyxYzV9xTd19qjX8ot1akrYDZk2ndgSEzb77nwucCNZvNv3hh0Dj8
         MdJEjoaLwjSFtPdM3mu+eYEPlgVFIXpBKXUdPpTF/Ky9kp3v2gnn7wCV+tohcM987GDr
         4/bMytV9MHSSAZrTx8UpUX3YU5EX4ZdVNZL9fcm2/XdAflw0P8v/2X7csi6xnHsQYkGR
         9rA5T1AL6AMjpSccQ7BWsQ+f5Py6gR6B27OTzebrD1GL3EPMryyp/NzoRwbhh+XexUiE
         XBfw==
X-Gm-Message-State: APjAAAW/67r486LHsIgDzOGuvg0ZC9wcMCQ8R4XXvWI88Z1U85Fa5rsn
        J0+/sOisLAA8YoNBDBPwWjff5g==
X-Google-Smtp-Source: APXvYqxER6ionZR5dWUWPafoltmghKq39SdTXF/QPkvTy92PPli9V9NxGsvjCPySp2bn16BrcE682g==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr13229228wrp.6.1557746925751;
        Mon, 13 May 2019 04:28:45 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z9sm15023246wma.39.2019.05.13.04.28.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 04:28:44 -0700 (PDT)
Message-ID: <10e588ae1e259c2c2bc9cfd0e788aa41735f0f66.camel@baylibre.com>
Subject: Re: [PATCH 0/3] mmc: meson-gx: add ddr-access-quirk support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org,
        khilman@baylibre.com
Cc:     baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 May 2019 13:28:43 +0200
In-Reply-To: <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
         <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2019-05-13 at 11:58 +0200, Jerome Brunet wrote:
> > The performance hit hasn't been evaluated, but the fix has been tested
> > using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> > 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> > at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.
> 
> These numbers looks to be limited by the MMC bandwidth of the related modes.
> So, if the SRAM quirk introduce a penalty for the controller, it does not appear
> to be a limiting factor, AFAICT.

Got confused. This comment is completely wrong, please ignore

