Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3751F2A10A5
	for <lists+linux-mmc@lfdr.de>; Fri, 30 Oct 2020 23:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJ3WEN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 30 Oct 2020 18:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3WEN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Oct 2020 18:04:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D60C0613CF
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2020 15:04:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v5so4154907wmh.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2020 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=iLoiu1GZPoeyLaOUIzIb7hrIHQg3p70W9JlIXcT64Iw=;
        b=u4upi2GGkctVojzKJWhhmzuLuEk9c4NOvdcGJrKD3bR9DBWPc+qS8fhVlXh+Vgd/Ye
         Q+iqfvlmTnyFyAXSzK1qy9iF4cpbYMh4k700ilzgvXwFAI3lYWy6eEU5gc+izbAaY82w
         Hh2Zt6esPrOdBP3lR85355JmauaFefO9tVsridpeUvN15rXhPN0GdChNhEYbvXZIeTL/
         H5Bat7+J3nQ/wVV8u0vJ5of2tmdPtOWnQXpm4mPnhoS2HzgtRUuT1qCuZJGTDUi5g+ze
         HifW2Ys2LejDwCfboT8daxQKUeVys+lw1o7iZJFpGR8D1QS6UgDypkeohNQYizdznfbH
         1LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=iLoiu1GZPoeyLaOUIzIb7hrIHQg3p70W9JlIXcT64Iw=;
        b=Q2BP/6QHFdGrp0t2rt5bq4+jr5akQPwTy2macoYXIlwKOFjiaFGBMP9E8WBhK2yqeC
         l0JrvCCVP1vUuNZUyJg4oA1y73gZ0cXC2nYbnE92LlTT9Nq/dNNcOArFKxpbybowifdZ
         bjicWR5v8cjpw+A9oqCmXj9zn1c4WnNxwhxh8xXuj3qlCno/VKg2e7ZpjA/1Q7U4Zn6u
         0JkotBCrneDo160tgtTwMINu2wCAwc7z8RNf4drPYCZaOdLQMkhGHfvhZ1M7xmkDXYGQ
         4HRFr39jmOg4sj4e8KS6zQpM9gECIAdj848MtUhw8Cc0v71Ro5mdf3ut50ByzB3vY70s
         tpdw==
X-Gm-Message-State: AOAM530knhlcQZZ2QHNQcE+hzLgakjdwINOVJ28kfbeuZzP2YJmz270D
        biKsQRUbje1UlIv0mzd5qgQ=
X-Google-Smtp-Source: ABdhPJxNx2FViMFM6B8GLTdqE1k/VawizE0D88MeDuYA2OSKK136g8CLaGR62/ZcUBpIJAHSS5VFuA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr4846779wma.126.1604095451926;
        Fri, 30 Oct 2020 15:04:11 -0700 (PDT)
Received: from localhost ([170.253.46.69])
        by smtp.gmail.com with ESMTPSA id y200sm1785428wmc.23.2020.10.30.15.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 15:04:11 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <treding@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, <linux-mmc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [regression, bisected] no MMC on rk3399-gru-kevin with 5.10-rc1
Date:   Fri, 30 Oct 2020 23:04:09 +0100
MIME-Version: 1.0
Message-ID: <59a5676c-cbf7-4a8e-ace1-f079e09d21a8@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
commit 21b2cec61c04bd175f0860d9411a472d5a0e7ba1
mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4
broke booting rk3399-gru-kevin.

The kernel waits forever for the root device to appear on MMC.
Removing the line containing PROBE_PREFER_ASYNCHRONOUS in
drivers/mmc/host/dw_mmc-rockchip.c fixes the issue.

Regards,
  Vicente.

