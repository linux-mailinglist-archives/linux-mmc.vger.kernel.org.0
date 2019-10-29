Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D71E87A0
	for <lists+linux-mmc@lfdr.de>; Tue, 29 Oct 2019 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfJ2L7M (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 29 Oct 2019 07:59:12 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:36744 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2L7M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2019 07:59:12 -0400
Received: by mail-wr1-f52.google.com with SMTP id w18so13353238wrt.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2019 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ogi-it-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Pi9/wpdJR9sHbzI4GyyYWPRw4rG9S8bqOGf0nLwygEI=;
        b=vFvya8kHHbf+4ZmpgqwDh4ARRMVxuxuzwYYx7X/T5q1lZmvGHmJ7pKfjgbktS3hLSR
         6Mp6pEVpnEg2Z0RN0ipV9lGFnlcKqJGpsms7vyKwxkFNZYfjNTHuRO34+nDUaNbVH7lU
         RDsi0Uvi8YHUwPNTH7y60yhqBroN0QEjSjxE258VwF3JC1+IY57Wby2VTw7TtY33jeqn
         Rq2+RwMuDjCjOrdEuz0wHgxJ16bM+dJTbzXCDHuSJftvD35EMB+1skAvwUIy59i0HoOK
         cVnk9bmN03dmnlIAmZsCzVmRa+WK/rjJJgLHKP51F0o7UeJj4kNl3+q3Xjj4AGEHiK6N
         OCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Pi9/wpdJR9sHbzI4GyyYWPRw4rG9S8bqOGf0nLwygEI=;
        b=SpqiWwGz0FYLEU5UJg0g4g4VcK0k1Xwpcq48jWs/Cdqry3mv1xGkiAyiGQDjZP8rKC
         TI6+hBCqXTD+YiwriZ5WM9mYWn81+XVR3baCgAL/dLKxlWEGlztrBDI+Hd9V4I/yOGpI
         97jX5hy/xyNS9XRCX9DNV2V/yNyByIdOrD0dSYXo2taNPmG47QNZbFICRVBqSKLCEslb
         fIgNHBtJypZzl/fU3Ez6odqxMRTH/Q6LQ/ClYCKuS/MZXW3KcDM3VAI6H5dbnb8JFn8I
         Y3TIuT+zwiI4UduvtYmxHVjZR5uf5PoVvo1eV3kSjPN4VwB1q6n6quWh5t7K2yXMyjJr
         F9eA==
X-Gm-Message-State: APjAAAXJvAnAMjiQFPivLQXVWW1lc4eb8wfsfOhT2lYnKFHlCj5uEeK5
        EVJV7lkQ12p0ukIde2FTfJJAx7PMNgU=
X-Google-Smtp-Source: APXvYqzPLoCjLB00o3j32SWNg50BPMX4dl6WQwRJ/D5jeV4z3IbPK7JYjaeYS/Fm3fGENXtN8TW8wg==
X-Received: by 2002:a5d:5591:: with SMTP id i17mr18598752wrv.151.1572350350082;
        Tue, 29 Oct 2019 04:59:10 -0700 (PDT)
Received: from ogi-it-mac.level1.ogi-it.com (84-112-46-163.cable.dynamic.surfer.at. [84.112.46.163])
        by smtp.gmail.com with ESMTPSA id p12sm14798555wrt.7.2019.10.29.04.59.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 04:59:09 -0700 (PDT)
From:   DDI Ognian Tschakalov <ognian.tschakalov@ogi-it.com>
X-Google-Original-From: DDI Ognian Tschakalov <Ognian.Tschakalov@ogi-it.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: SD card reader via USB as /dev/mmcblk0
Message-Id: <1B783715-DB28-4148-915A-5FDFB6299E6F@ogi-it.com>
Date:   Tue, 29 Oct 2019 12:59:08 +0100
To:     linux-mmc@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Hello,
please excuse me posting this to this list, but I couldn=E2=80=99t think =
of any other solution.
I desperate need a way to test sd cards in a Linux VM on my laptop =
(macbook pro). All the USB (USB2 and USB3) readers i tested end up as =
/dev/sdx and not /dev/mmcblkx.
Does anyone know a SD card reader (brand, model) connected via USB2, =
USB3 or even thunderbolt which is recognised as /dev/mmcblkx?
Thanks a lot
Ognian

DDI Ognian Tschakalov


